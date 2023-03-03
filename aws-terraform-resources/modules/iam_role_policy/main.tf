// modules/iam_role_policy/main.tf

resource "aws_iam_role" "role" {
  name = var.name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "policy" {
  name        = var.policy_name
  policy      = var.policy
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  policy_arn = aws_iam_policy.policy.arn
  role       = aws_iam_role.role.name
}

// modules/iam_role_policy/variables.tf

variable "name" {
  type        = string
  description = "The name of the IAM role to create"
}

variable "policy_name" {
  type        = string
  description = "The name of the IAM policy to create"
}

variable "policy" {
  type        = string
  description = "The IAM policy to attach to the role"
}

// modules/iam_role_policy/outputs.tf

output "role_arn" {
  value = aws_iam_role.role.arn
}

output "policy_arn" {
  value = aws_iam_policy.policy.arn
}
