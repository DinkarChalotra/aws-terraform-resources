module "sns" {
  source = "./sns"
  
  topic_name = "my-sns-topic"
  subscription_endpoint = "example@example.com"
  subscription_protocol = "email"
}
