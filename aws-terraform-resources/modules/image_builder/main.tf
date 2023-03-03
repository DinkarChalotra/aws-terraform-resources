resource "aws_imagebuilder_component" "example_component" {
  name                  = var.name
  platform              = var.platform
  data                  = var.data
  version               = var.version
  description           = var.description
  change_description     = var.change_description
  supported_os_versions = var.supported_os_versions
}

variable "name" {
  type        = string
  description = "The name of the EC2 Image Builder component to create."
}

variable "platform" {
  type        = string
  description = "The platform of the component. Valid values are Linux and Windows."
  default     = "Linux"
}

variable "data" {
  type        = string
  description = "The data of the component."
}

variable "version" {
  type        = string
  description = "The version of the component."
  default     = "0.0.1"
}

variable "description" {
  type        = string
  description = "The description of the component."
}

variable "change_description" {
  type        = string
  description = "The change description of the component."
}

variable "supported_os_versions" {
  type        = list(string)
  description = "The list of supported OS versions for the component."
}
