// s3_bucket.tf

module "s3_bucket" {
  source = "./modules/s3_bucket"

  name = "my-s3-bucket"
  environment = "prod"
}
