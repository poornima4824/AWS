# VPC Configuration
vpc_id = "vpc-0a6cf673aa37f41b2"

# ID of the existing Private Subnets
vpc_spoke_public_subnet_ids = ["subnet-037c13388fd4ad82a", "subnet-0d6b9e156324f415e"]

vpc_spoke_private_subnet_ids=["subnet-087c7ebe8373d6d3c","subnet-0351c65e7eccfdc42"]

# EKS Cluster Name
eks_cluster_name = "aws-eks-infra-prov"

# EKS Cluster Version
eks_cluster_version = "1.28"

# Node Group Configuration
node_group_name          = "aws-nodegroup-infra-prov"
worker_instance_type     = ["t3.small"]
desired_size             = 5
min_size                 = 3
max_size                 = 7
worker_nodes_count       = 2

# Region
region = "us-east-1"

# EKS-Addon
addons = [
  {
    name    = "kube-proxy"
    version = "v1.28.4-eksbuild.4"
  },
  {
    name    = "vpc-cni"
    version = "v1.16.0-eksbuild.1"
  },
  {
    name    = "coredns"
    version = "v1.10.1-eksbuild.6"
  },
  {
    name    = "aws-ebs-csi-driver"
    version = "v1.26.1-eksbuild.1"
  },
  {
    name    = "aws-efs-csi-driver"
    version = "v1.7.2-eksbuild.1"
  }
]

#Fargate Variables
fp_name="fargate-profile"
require_fargate_compute=true
namespace="fp-dev"
pvt_route_table_id="rtb-07a8a7e35421e1f8f"
