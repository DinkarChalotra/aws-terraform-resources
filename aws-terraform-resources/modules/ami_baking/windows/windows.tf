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

resource "aws_ssm_association" "windows_patches" {
  name = "AWS-InstallWindowsUpdates"
  parameters = {
    "Filters"   = [
      "{\"Name\":\"IsInstalled\",\"Values\":[\"False\"]}",
      "{\"Name\":\"Classification\",\"Values\":[\"CriticalUpdates\",\"SecurityUpdates\"]}",
      "{\"Name\":\"ExcludeArchitectures\",\"Values\":[\"i386\"]}",
      "{\"Name\":\"Properties\",\"Values\":[\"IsInstalled\",\"Classification\",\"Title\",\"KBID\",\"KBArticleID\",\"Description\"]}"
    ]
  }
  targets = [
    {
      key    = "InstanceIds"
      values = [aws_instance.bake_instance.id]
    }
  ]
}

resource "aws_ami" "
