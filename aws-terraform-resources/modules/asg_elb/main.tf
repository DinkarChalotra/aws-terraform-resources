resource "aws_security_group" "asg_security_group" {
  name_prefix = "${var.name_prefix}-asg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "asg_security_group_rule" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.asg_security_group.id
}

resource "aws_launch_configuration" "example_launch_configuration" {
  name_prefix = var.name_prefix
  image_id    = var.image_id
  instance_type = var.instance_type

  security_groups = [
    aws_security_group.asg_security_group.id,
  ]
  key_name        = var.key_name

  user_data = var.user_data
}

resource "aws_autoscaling_group" "example_autoscaling_group" {
  name = var.name_prefix
  launch_configuration = aws_launch_configuration.example_launch_configuration.name

  vpc_zone_identifier = var.subnet_ids

  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  load_balancers = [
    var.elb_name,
  ]
}

resource "aws_elb" "example_elb" {
  name = var.elb_name

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  security_groups = [
    aws_security_group.asg_security_group.id,
  ]

  subnets = var.subnet_ids
}

variable "name_prefix" {
  type        = string
  description = "The prefix to use for the name of the launch configuration, the autoscaling group, and the ELB."
}

variable "image_id" {
  type        = string
  description = "The ID of the AMI to use for the launch configuration."
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the launch configuration."
}

variable "key_name" {
  type        = string
  description = "The name of the key pair to use for the instances launched by the launch configuration."
}

variable "user_data" {
  type        = string
  default     = null
  description = "The user data to use for the instances launched by the launch configuration."
}

variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnet IDs in which to launch the instances and the ELB."
}

variable "desired_capacity" {
  type        = number
  description = "The desired number of instances in the autoscaling group."
}

variable "max_size" {
  type        = number
  description = "The maximum number of instances in the autoscaling group."
  }

variable "min_size" {
  type        = number
  description = "The minimum number of instances in the autoscaling group."
}

variable "elb_name" {
  type        = string
  description = "The name of the ELB."
}

