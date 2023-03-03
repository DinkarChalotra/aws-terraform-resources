resource "aws_elastic_beanstalk_application" "example_app" {
  name        = var.application_name
  description = var.application_description
}

resource "aws_elastic_beanstalk_environment" "example_env" {
  name                = var.environment_name
  application         = aws_elastic_beanstalk_application.example_app.name
  solution_stack_name = var.solution_stack_name
  tier                = var.tier

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.min_size
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.max_size
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = var.environment_type
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = var.system_type
  }
}

variable "application_name" {
  type        = string
  description = "The name of the Elastic Beanstalk application to create."
}

variable "application_description" {
  type        = string
  description = "The description of the Elastic Beanstalk application to create."
}

variable "environment_name" {
  type        = string
  description = "The name of the Elastic Beanstalk environment to create."
}

variable "solution_stack_name" {
  type        = string
  description = "The name of the Elastic Beanstalk solution stack to use."
}

variable "tier" {
  type        = string
  description = "The tier of the Elastic Beanstalk environment to create."
  default     = "WebServer"
}

variable "min_size" {
  type        = number
  description = "The minimum number of instances to run in the Elastic Beanstalk environment."
  default     = 1
}

variable "max_size" {
  type        = number
  description = "The maximum number of instances to run in the Elastic Beanstalk environment."
  default     = 3
}

variable "environment_type" {
  type        = string
  description = "The environment type of the Elastic Beanstalk environment to create."
  default     = "LoadBalanced"
}

variable "system_type" {
  type        = string
  description = "The system type of the Elastic Beanstalk environment to create."
  default     = "enhanced-health"
}
