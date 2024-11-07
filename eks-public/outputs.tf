  output "eks_cluster_name_output_infra_prov" {
    value       = var.eks_cluster_name
    description = "Output for EKS cluster name"
  }

  output "eks_cluster_version_output_infra_prov" {
    value       = var.eks_cluster_version
    description = "Output for EKS cluster version"
  }
  
  output "node_group_name_output_infra_prov" {
    value       = var.node_group_name
    description = "Output for EKS node group name"
  }

  output "worker_instance_type_output_infra_prov" {
    value       = var.worker_instance_type
    description = "Output for EC2 instance types for worker nodes"
  }

  output "desired_size_output_infra_prov" {
    value       = var.desired_size
    description = "Output for desired number of worker nodes"
  }

  output "min_size_output_infra_prov" {
    value       = var.min_size
    description = "Output for minimum number of worker nodes"
  }

  output "max_size_output_infra_prov" {
    value       = var.max_size
    description = "Output for maximum number of worker nodes"
  }
#Fargate outputs
output "eks_fargate_profile_id" {
  description = "EKS Fargate Profile id"
  value       = aws_eks_fargate_profile.fargate_profile[0].id
}

output "eks_fargate_profile_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Fargate Profile"
  value       = aws_eks_fargate_profile.fargate_profile[0].arn
}

output "eks_fargate_profile_status" {
  description = "Status of the EKS Fargate Profile"
  value       = aws_eks_fargate_profile.fargate_profile[0].status
}
