resource "aws_iam_user" "example_user" {
  name = var.username
  path = var.user_path

  tags = var.tags
}

resource "aws_iam_access_key" "example_access_key" {
  user = aws_iam_user.example_user.name

  tags = var.tags
}

resource "aws_iam_user_policy_attachment" "example_policy_attachment" {
  user       = aws_iam_user.example_user.name
  policy_arn = var.policy_arn
}

variable "username" {
  type        = string
  description = "The name of the IAM user to create."
}

variable "user_path" {
  type        = string
  default     = "/"
  description = "The path for the IAM user."
}

variable "policy_arn" {
  type        = string
  description = "The ARN of the policy to attach to the IAM user."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the IAM user and access key."
}
