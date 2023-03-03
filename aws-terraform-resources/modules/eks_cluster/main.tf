resource "aws_eks_cluster" "example_eks" {
  name     = var.cluster_name
  role_arn = var.eks_role_arn
  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = var.security_group_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access = var.endpoint_public_access
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster,
    aws_iam_role_policy_attachment.eks_node_group,
  ]
}

resource "aws_iam_role" "example_eks_role" {
  name = var.eks_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.example_eks_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_group" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.example_eks_role.name
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster to create."
}

variable "eks_role_name" {
  type        = string
  description = "The name of the IAM role to associate with the EKS cluster."
}

variable "eks_role_arn" {
  type        = string
  description = "The ARN of the IAM role to associate with the EKS cluster."
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to use for the EKS cluster VPC configuration."
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to use for the EKS cluster VPC configuration."
}

variable "endpoint_private_access" {
  type        = bool
  description = "Whether or not to enable private access to the EKS cluster API server."
}

variable "endpoint_public_access" {
  type        = bool
  description = "Whether or not to enable public access to the EKS cluster API server."
}
