// modules/security_group/main.tf

resource "aws_security_group" "ec2_security_group" {
  name_prefix = var.name_prefix
  description = var.description

  ingress {
    from_port   = var.ingress_from_port
    to_port     = var.ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = {
    Name = var.name_prefix
  }
}

// modules/security_group/variables.tf

variable "name_prefix" {
  type        = string
  description = "The name prefix for the security group"
}

variable "description" {
  type        = string
  description = "The description for the security group"
}

variable "ingress_from_port" {
  type        = number
  description = "The starting port for ingress rules"
}

variable "ingress_to_port" {
  type        = number
  description = "The ending port for ingress rules"
}

variable "ingress_protocol" {
  type        = string
  description = "The protocol for ingress rules (e.g. tcp, udp, icmp)"
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "The CIDR blocks to allow ingress traffic from"
}

variable "egress_from_port" {
  type        = number
  description = "The starting port for egress rules"
}

variable "egress_to_port" {
  type        = number
  description = "The ending port for egress rules"
}

variable "egress_protocol" {
  type        = string
  description = "The protocol for egress rules (e.g. tcp, udp, icmp)"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "The CIDR blocks to allow egress traffic to"
}

// modules/security_group/outputs.tf

output "security_group_id" {
  value = aws_security_group.ec2_security_group.id
}

output "security_group_name" {
  value = aws_security_group.ec2_security_group.name
}
