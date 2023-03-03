// r53_record.tf

module "r53_record" {
  source = "./modules/r53_record"

  zone_id = "Z1234567890"
  name    = "example.com"
  type    = "A"
  ttl     = 300
  records = ["10.0.0.1", "10.0.0.2"]
}
