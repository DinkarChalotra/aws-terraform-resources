resource "aws_lambda_function" "example_lambda" {
  function_name = var.function_name
  handler      = var.handler
  runtime      = var.runtime
  memory_size  = var.memory_size
  timeout      = var.timeout
  role         = var.role
  source_code_hash = filebase64sha256(var.code_location)
}

variable "function_name" {
  type        = string
  description = "The name of the Lambda function to create."
}

variable "handler" {
  type        = string
  description = "The entry point for the Lambda function."
}

variable "runtime" {
  type        = string
  description = "The runtime environment for the Lambda function."
}

variable "memory_size" {
  type        = number
  description = "The amount of memory to allocate for the Lambda function."
}

variable "timeout" {
  type        = number
  description = "The maximum amount of time to allow for the Lambda function to execute."
}

variable "role" {
  type        = string
  description = "The ARN of the IAM role to associate with the Lambda function."
}

variable "code_location" {
  type        = string
  description = "The local path to the code directory to upload as the Lambda function source."
}
