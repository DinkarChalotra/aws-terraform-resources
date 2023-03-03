resource "aws_serverlessapplicationrepository_cloudformation_stack" "example_stack" {
  name        = var.stack_name
  description = var.stack_description
  template_body = file(var.template_file_path)
  tags        = var.tags
}

variable "stack_name" {
  type        = string
  description = "The name of the Serverless Application Repository application stack to create."
}

variable "stack_description" {
  type        = string
  description = "The description of the Serverless Application Repository application stack to create."
}

variable "template_file_path" {
  type        = string
  description = "The path to the CloudFormation template file for the Serverless Application Repository application."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to the Serverless Application Repository application."
}
