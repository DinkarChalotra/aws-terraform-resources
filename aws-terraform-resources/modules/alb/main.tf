// modules/alb/main.tf

resource "aws_lb" "alb" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.security_group_id]

  subnets = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name = var.name
  }
}

// modules/alb/variables.tf

variable "name" {
  type        = string
  description = "The name of the ALB"
}

variable "internal" {
  type        = bool
  description = "Whether the ALB is internal or external"
}

variable "load_balancer_type" {
  type        = string
  description = "The type of load balancer to create (application or network)"
}

variable "security_group_id" {
  type        = string
  description = "The ID of the security group to attach to the ALB"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The IDs of the subnets to attach the ALB to"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection for the ALB"
}

// modules/alb/outputs.tf

output "alb_id" {
  value = aws_lb.alb.id
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}
