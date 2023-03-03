# Required providers
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}

# Variables
variable "region" {
  description = "AWS region to use"
}

variable "source_ami" {
  description = "The ID of the source AMI to use for the instance"
}

variable "instance_type" {
  description = "The instance type to use for the instance"
  default     = "t2.micro"
}

variable "ami_name" {
  description = "The name of the AMI to create"
}

# Resources
resource "aws_instance" "bake_instance" {
  ami           = var.source_ami
  instance_type = var.instance_type
}

resource "aws_ssm_association" "linux_patches" {
  name = "AWS-RunPatchBaseline"
  parameters = {
    "Operation"  = ["Install"]
    "PatchOrchestrator" = ["AWS-RunPatchBaseline"]
    "BaselineId" = ["string:your-baseline-id"]
  }
  targets = [
    {
      key    = "InstanceIds"
      values = [aws_instance.bake_instance.id]
    }
  ]
}

resource "aws_ami" "bake_ami" {
  name                = var.ami_name
  instance_id         = aws_instance.bake_instance.id
  root_device_name    = "/dev/xvda"
  virtualization_type = "hvm"
  ebs_block_device    = [
    {
      device_name = "/dev/xvda"
      volume_size = 8
      volume_type = "gp2"
      delete_on_termination = true
    },
  ]
}
