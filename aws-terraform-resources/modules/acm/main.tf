// modules/acm/main.tf

resource "aws_acm_certificate" "cert" {
  domain_name = var.domain_name
  validation_method = var.validation_method

  tags = {
    Environment = var.environment
  }
}

// modules/acm/variables.tf

variable "domain_name" {
  type        = string
  description = "The domain name for the certificate"
}

variable "validation_method" {
  type        = string
  description = "The validation method for the certificate (e.g. DNS, EMAIL)"
}

variable "environment" {
  type        = string
  description = "The environment name to add as a tag for the certificate"
}

// modules/acm/outputs.tf

output "arn" {
  value = aws_acm_certificate.cert.arn
}
