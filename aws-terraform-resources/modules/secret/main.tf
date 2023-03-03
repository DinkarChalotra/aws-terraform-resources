resource "aws_secretsmanager_secret" "example_secret" {
  name = var.name
}

resource "aws_secretsmanager_secret_version" "example_secret_version" {
  secret_id     = aws_secretsmanager_secret.example_secret.id
  secret_string = jsonencode(var.secret_data)
}

variable "name" {
  type        = string
  description = "The name of the secret to create."
}

variable "secret_data" {
  type        = map(any)
  description = "A map of key-value pairs to store as the secret data."
}
