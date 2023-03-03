resource "aws_iam_policy" "iam_boundary_policy" {
  name        = var.policy_name
  path        = var.policy_path
  policy      = var.policy_document
  description = var.policy_description
}

variable "policy_name" {
  type        = string
  description = "The name of the IAM boundary policy to create."
}

variable "policy_path" {
  type        = string
  description = "The path of the IAM boundary policy to create."
}

variable "policy_document" {
  type        = string
  description = "The JSON policy document for the IAM boundary policy to create."
}

variable "policy_description" {
  type        = string
  description = "The description of the IAM boundary policy to create."
}
