// r53.tf

module "r53" {
  source = "./modules/r53"

  name        = "example.com"
  comment     = "This is an example Route 53 hosted zone"
  environment = "dev"
}
