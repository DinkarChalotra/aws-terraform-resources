resource "aws_servicequotas_service" "openshift_service" {
  service_code = "rh-os"
}

resource "aws_servicequotas_service_quota" "openshift_quota" {
  service_code = aws_servicequotas_service.openshift_service.service_code
  quota_code   = "L-0190"
}

resource "aws_redshift_parameter_group" "example" {
  name = "example"
  family = aws_redshift_parameter_group_family.example.family

  parameter {
    name = "wlm_json_configuration"
    value = "{\"query_concurrency_scaling\":{\"min_clusters\":1,\"max_clusters\":1}}"
    apply_method = "pending-reboot"
  }
}

resource "aws_redshift_parameter_group_family" "example" {
  family = "redshift-1.0"
}

variable "cluster_name" {
  type        = string
  description = "The name of the OpenShift cluster to create."
}

variable "openshift_version" {
  type        = string
  description = "The version of OpenShift to use."
}

variable "openshift_worker_size" {
  type        = string
  description = "The instance type to use for the OpenShift worker nodes."
}

variable "openshift_worker_count" {
  type        = number
  description = "The number of OpenShift worker nodes to create."
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to use for the OpenShift cluster VPC configuration."
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to use for the OpenShift cluster VPC configuration."
}

variable "admin_username" {
  type        = string
  description = "The username for the OpenShift cluster admin user."
}

variable "admin_password" {
  type        = string
  description = "The password for the OpenShift cluster admin user."
}

resource "aws_redshift_cluster" "example" {
  cluster_identifier   = var.cluster_name
  node_type            = var.openshift_worker_size
  number_of_nodes      = var.openshift_worker_count
  cluster_subnet_group_name = aws_redshift_subnet_group.example.name
  vpc_security_group_ids    = var.security_group_ids
  publicly_accessible        = false
  iam_roles                  = aws_iam_role.example.arn
  cluster_parameter_group_name = aws_redshift_parameter_group.example.name
  tags = {
    Name = var.cluster_name
  }
}

resource "aws_redshift_subnet_group" "example" {
  name = "example"
  subnet_ids = var.subnet_ids
}

resource "aws_iam_role" "example" {
  name = "example"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "redshift.amazonaws.com"
        }
      }
    ]
  })
}
