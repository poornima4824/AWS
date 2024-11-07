variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "vpc_spoke_public_subnet_ids" {
 type        = list(string)
 description = "Public Subnet values"
}

variable "vpc_spoke_private_subnet_ids" {
 type        = list(string)
 description = "Private Subnet values"
 default     = ["subnet-01437bb00ba9cf0f9", "subnet-0135a0da32508730e"]
}

variable "pvt_route_table_id" {
  type = string
  description = "Route table ID of the private subnets"
}

variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "eks_cluster_version" {
  type        = string
  description = "Version of the EKS cluster"
}

variable "node_group_name" {
  type        = string
  description = "Name of the EKS node group"
}

variable "worker_instance_type" {
  type        = list(string)
  description = "List of EC2 instance types for worker nodes"
  default     = ["t3.small"]
}

variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes"
  default     = 2
}

variable "min_size" {
  type        = number
  description = "Minimum number of worker nodes"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of worker nodes"
  default     = 3
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))
  description = "List of EKS addons to be installed on the cluster"

  default = [
    {
      name    = "kube-proxy"
      version = "v1.28.1-eksbuild.1"
    },
    {
      name    = "vpc-cni"
      version = "v1.14.1-eksbuild.1"
    },
    {
      name    = "coredns"
      version = "v1.10.1-eksbuild.2"
    },
    {
      name    = "aws-ebs-csi-driver"
      version = "v1.26.0-eksbuild.1"
    },
    {
      name    = "aws-efs-csi-driver"
      version = "v1.7.2-eksbuild.1"
    }
  ]
}

variable "worker_nodes_count" {
  type        = number
  description = "Number of worker nodes"
  default     = 2
}

#Fargate variables
variable "fp_name" {
  description = "Name of the faragte profile"
  type=string
  default = "fargate-profile"
  }


variable "require_fargate_compute" {
  description = "Boolean variable to add Fargate compute to cluster"
  type = bool
  default = false
}

variable "namespace" {
  description = "Name of the namespace in which fargate pods gets created"
  type=string
  default = "fp-dev"
  }


