// acm.tf

module "acm" {
  source = "./modules/acm"

  domain_name       = "example.com"
  validation_method = "DNS"
  environment       = "dev"
}
