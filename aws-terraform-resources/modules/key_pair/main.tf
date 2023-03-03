resource "aws_key_pair" "example_key_pair" {
  key_name   = var.key_name
  public_key = var.public_key
}

variable "key_name" {
  type        = string
  description = "The name for the key pair."
}

variable "public_key" {
  type        = string
  description = "The public key material."
}
