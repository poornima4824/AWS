# Data block to fetch VPC ID
data "aws_vpc" "existing-vpc-infra-prov" {
  id = var.vpc_id
}

# Create IAM role for EKS cluster
resource "aws_iam_role" "aws-eks-iam-role-infra-prov" {
  name = "aws-eks-cluster-role-infra-prov"

  path = "/"

  # Defining the assume role policy for EKS cluster
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com",
        },
        Action = "sts:AssumeRole",
      },
    ],
  })
}

# Attach policies to the EKS IAM role
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy_infra_prov" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.aws-eks-iam-role-infra-prov.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS_infra_prov" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.aws-eks-iam-role-infra-prov.name
}

# Create EKS cluster
resource "aws_eks_cluster" "aws-eks-infra-prov" {
  name      = var.eks_cluster_name
  role_arn  = aws_iam_role.aws-eks-iam-role-infra-prov.arn
  version   = var.eks_cluster_version

  vpc_config {
    subnet_ids               = var.vpc_spoke_public_subnet_ids
    endpoint_private_access = false
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role.aws-eks-iam-role-infra-prov,
  ]

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

# Dependencies for OIDC setup
data "tls_certificate" "aws-eks-oidc-cer-infra-prov" {
  url = aws_eks_cluster.aws-eks-infra-prov.identity[0].oidc[0].issuer
}

# Create OIDC provider for EKS cluster
resource "aws_iam_openid_connect_provider" "aws-eks-oidc-provider-infra-prov" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.aws-eks-oidc-cer-infra-prov.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.aws-eks-infra-prov.identity[0].oidc[0].issuer

  depends_on = [aws_eks_cluster.aws-eks-infra-prov]
}

# Set up an IAM role for the worker nodes
resource "aws_iam_role" "aws-workernodes-iam-role-infra-prov" {
  name = "aws-nodegroup-role-infra-prov"

  # Assume role policy for worker nodes
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
      },
      {
        Action = "sts:AssumeRoleWithWebIdentity",
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.aws-eks-oidc-provider-infra-prov.arn,
        },
        Condition = {
          StringEquals = {
            "sts:aud" = "sts.amazonaws.com", # Update this value if needed
          },
        },
      },
    ],
  })
}

# Attach policies to the worker nodes IAM role
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy_infra_prov" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.aws-workernodes-iam-role-infra-prov.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy_infra_prov" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.aws-workernodes-iam-role-infra-prov.name
}

resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds_infra_prov" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role       = aws_iam_role.aws-workernodes-iam-role-infra-prov.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly_infra_prov" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.aws-workernodes-iam-role-infra-prov.name
}

# Create Worker nodes in public subnets only
resource "aws_eks_node_group" "aws-nodegroup-infra-prov" {
  count           = var.worker_nodes_count
  cluster_name    = aws_eks_cluster.aws-eks-infra-prov.name
  node_group_name = "${var.node_group_name}-${count.index}"
  node_role_arn   = aws_iam_role.aws-workernodes-iam-role-infra-prov.arn
  subnet_ids      = var.vpc_spoke_public_subnet_ids
  instance_types  = var.worker_instance_type

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy_infra_prov,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy_infra_prov,
    aws_iam_role_policy_attachment.EC2InstanceProfileForImageBuilderECRContainerBuilds_infra_prov,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly_infra_prov,
  ]
}

# Create addons for the EKS cluster
resource "aws_eks_addon" "aws-eks-addons-infra-prov" {
  for_each          = { for idx, addon in var.addons : idx => addon }
  cluster_name      = aws_eks_cluster.aws-eks-infra-prov.name
  addon_name        = each.value.name
  addon_version     = each.value.version
  resolve_conflicts = "OVERWRITE"

  depends_on = [aws_eks_node_group.aws-nodegroup-infra-prov]
}

# Adding Fargate Logic configurable
resource "aws_eks_fargate_profile" "fargate_profile" {
  count = var.require_fargate_compute ? 1 : 0
  cluster_name           = aws_eks_cluster.aws-eks-infra-prov.name
  fargate_profile_name   = var.fp_name
  pod_execution_role_arn = aws_iam_role.eks-fargate-profile[0].arn
  subnet_ids = var.vpc_spoke_private_subnet_ids

  selector {
    namespace = var.namespace
  }
}

# IAM for fargate

resource "aws_iam_role" "eks-fargate-profile" {
  count = var.require_fargate_compute ? 1 : 0
  name = "${var.fp_name}-IAM-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-fargate-profile" {
  count = var.require_fargate_compute ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.eks-fargate-profile[0].name
}

# Creating NAT for private subnets
data "aws_route_table" "existing_route_table" {
  route_table_id = var.pvt_route_table_id
}

resource "aws_eip" "nat_eip" {
  instance = null
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.vpc_spoke_public_subnet_ids[0]
}
resource "aws_route" "route" {
  route_table_id         = data.aws_route_table.existing_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

