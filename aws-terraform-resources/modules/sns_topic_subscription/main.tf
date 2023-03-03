# main.tf

variable "topic_name" {
  description = "The name of the SNS topic"
}

variable "subscription_endpoint" {
  description = "The endpoint for the SNS subscription"
}

variable "subscription_protocol" {
  description = "The protocol for the SNS subscription"
}

resource "aws_sns_topic" "sns_topic" {
  name = var.topic_name
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = var.subscription_protocol
  endpoint  = var.subscription_endpoint
}
