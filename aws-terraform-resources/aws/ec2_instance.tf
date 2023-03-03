// ec2_instance.tf

module "ec2_instance" {
  source = "./modules/ec2_instance"

  name            = "my-ec2-instance"
  ami             = "ami-abc123"
  instance_type   = "t2.micro"
  key_name        = "my-key-pair"
  security_groups = ["sg-123abc"]

  // Optional user data script for configuring the instance
  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, world!" > /var/www/html/index.html
  EOF

 
