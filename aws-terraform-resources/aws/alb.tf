// alb.tf

module "alb" {
  source = "./modules/alb"

  name                       = "my-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_group_id          = "sg-0123456789abcdef"
  subnet_ids                 = ["subnet-0123456789abcdef", "subnet-0123456789abcdee"]
  enable_deletion_protection = true
}
