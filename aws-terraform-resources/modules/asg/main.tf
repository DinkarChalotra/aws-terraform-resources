resource "aws_launch_configuration" "example_launch_configuration" {
  name_prefix = var.name_prefix
  image_id    = var.image_id
  instance_type = var.instance_type

  security_groups = var.security_groups
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
}

variable "name_prefix" {
  type        = string
  description = "The prefix to use for the name of the launch configuration and the autoscaling group."
}

variable "image_id" {
  type        = string
  description = "The ID of the AMI to use for the launch configuration."
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the launch configuration."
}

variable "security_groups" {
  type        = list(string)
  description = "The list of security groups to associate with the launch configuration."
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
  description = "The list of subnet IDs in which to launch the instances."
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
