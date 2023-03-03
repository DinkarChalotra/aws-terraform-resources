// modules/r53_record/main.tf

resource "aws_route53_record" "r53_record" {
  zone_id = var.zone_id
  name    = var.name
  type    = var.type
  ttl     = var.ttl
  records = var.records
}

// modules/r53_record/variables.tf

variable "zone_id" {
  type        = string
  description = "The ID of the Route 53 hosted zone to create the record in"
}

variable "name" {
  type        = string
  description = "The name of the Route 53 record"
}

variable "type" {
  type        = string
  description = "The type of Route 53 record (e.g. A, CNAME, MX, etc.)"
}

variable "ttl" {
  type        = number
  description = "The TTL for the Route 53 record"
}

variable "records" {
  type        = list(string)
  description = "The records for the Route 53 record"
}

// modules/r53_record/outputs.tf

output "r53_record_fqdn" {
  value = "${var.name}.${aws_route53_record.r53_record.zone_id}"
}
