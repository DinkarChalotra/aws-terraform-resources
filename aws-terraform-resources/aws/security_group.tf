// security_group.tf

module "security_group" {
  source = "./modules/security_group"

  name_prefix        = "my-ec2-sg"
  description        = "Security group for my EC2 instances"
  ingress_from_port  = 22
  ingress_to_port    = 22
  ingress_protocol   = "tcp"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_from_port   = 0
  egress_to_port     = 0
  egress_protocol    = "-1"
  egress_cidr_blocks  = ["0.0.0.0/0"]
}
