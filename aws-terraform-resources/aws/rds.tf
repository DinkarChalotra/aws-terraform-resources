// rds.tf

provider "aws" {
  region = "us-east-1"
}

module "rds" {
  source = "./modules/rds"

  allocated_storage          = 100
  engine                     = "mysql"
  engine_version             = "5.7"
  instance_class             = "db.t2.micro"
  identifier                 = "example-db"
  username                   = "example-user"
  password                   = "example-password"
  publicly_accessible        = true
  storage_type               = "gp2"
  backup_retention_period    = 7
  deletion_protection        = true
  multi_az                   = false
  name                       = "Example RDS Instance"
  vpc_security_group_ids     = ["sg-0123456789abcdef0"]
  db_subnet_group_name       = "example-subnet-group"
}

output "rds_instance_id" {
  value = module.rds.db_instance_id
}

output "rds_instance_endpoint" {
  value = module.rds.db_instance_endpoint
}
      
