// modules/r53/main.tf

resource "aws_route53_zone" "r53_zone" {
  name = var.name
  comment = var.comment
  tags = {
    Environment = var.environment
  }
}

// modules/r53/variables.tf

variable "name" {
  type        = string
  description = "The name of the Route 53 hosted zone"
}

variable "comment" {
  type        = string
  description = "An optional comment for the Route 53 hosted zone"
}

variable "environment" {
  type        = string
  description = "The environment name to add as a tag for the Route 53 hosted zone"
}

// modules/r53/outputs.tf

output "r53_zone_id" {
  value = aws_route53_zone.r53_zone.id
}
