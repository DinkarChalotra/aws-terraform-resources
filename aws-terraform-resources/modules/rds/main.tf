// modules/rds/main.tf

resource "aws_db_instance" "db_instance" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier           = var.identifier
  username             = var.username
  password             = var.password
  publicly_accessible  = var.publicly_accessible
  storage_type         = var.storage_type
  backup_retention_period = var.backup_retention_period
  deletion_protection    = var.deletion_protection
  multi_az               = var.multi_az

  tags = {
    Name = var.name
  }

  vpc_security_group_ids = var.vpc_security_group_ids

  db_subnet_group_name = var.db_subnet_group_name
}

// modules/rds/variables.tf

variable "allocated_storage" {
  type        = number
  description = "The amount of allocated storage in GB"
}

variable "engine" {
  type        = string
  description = "The name of the database engine"
}

variable "engine_version" {
  type        = string
  description = "The version of the database engine"
}

variable "instance_class" {
  type        = string
  description = "The RDS instance class"
}

variable "identifier" {
  type        = string
  description = "The identifier for the RDS instance"
}

variable "username" {
  type        = string
  description = "The master username for the RDS instance"
}

variable "password" {
  type        = string
  description = "The master password for the RDS instance"
}

variable "publicly_accessible" {
  type        = bool
  description = "Whether the RDS instance should be publicly accessible"
}

variable "storage_type" {
  type        = string
  description = "The storage type for the RDS instance"
}

variable "backup_retention_period" {
  type        = number
  description = "The number of days to retain automated backups"
}

variable "deletion_protection" {
  type        = bool
  description = "Whether the RDS instance should be protected from deletion"
}

variable "multi_az" {
  type        = bool
  description = "Whether the RDS instance should be created as a Multi-AZ deployment"
}

variable "name" {
  type        = string
  description = "The name of the RDS instance (used for tags)"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "The security group IDs to associate with the RDS instance"
}

variable "db_subnet_group_name" {
  type        = string
  description = "The name of the DB subnet group to use for the RDS instance"
}

// modules/rds/outputs.tf

output "db_instance_id" {
  value = aws_db_instance.db_instance.id
}

output "db_instance_endpoint" {
  value = aws_db_instance.db_instance.endpoint
}
