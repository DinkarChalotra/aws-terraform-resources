resource "aws_ssm_parameter" "example_parameter" {
  name  = var.name
  type  = var.type
  value = var.value
}

variable "name" {
  type        = string
  description = "The name of the parameter to create."
}

variable "type" {
  type        = string
  description = "The type of the parameter. Valid values are String, StringList, and SecureString."
  default     = "String"
}

variable "value" {
  type        = string
  description = "The value of the parameter."
}
