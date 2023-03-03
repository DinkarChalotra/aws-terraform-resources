module "ami_baking_linux" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

  ami_name                 = "my-linux-ami-with-latest-patches"
  instance_type            = "t3.micro"
  security_groups          = ["${module.security_group_sg_id}"]
  subnet_id                = "${module.vpc_public_subnets[0]}"
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              EOF
}

module "ami_baking_windows" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

  ami_name                 = "my-windows-ami-with-latest-patches"
  instance_type            = "t3.micro"
  security_groups          = ["${module.security_group_sg_id}"]
  subnet_id                = "${module.vpc_public_subnets[0]}"
  associate_public_ip_address = true
  user_data = <<-EOF
              <powershell>
              Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
              Install-Module PSWindowsUpdate -Force
              Get-WindowsUpdate -Install -AcceptAll -AutoReboot
              </powershell>
              EOF
}

resource "aws_ssm_document" "linux_ami_baking_document" {
  name          = "my-linux-ami-baking-document"
  document_type = "Command"

  content = <<-EOT
              {
                  "schemaVersion": "2.2",
                  "description": "Document to update and bake AMI with the latest patches for Linux instances",
                  "parameters": {},
                  "runtimeConfig": {
                      "aws:runShellScript": {
                          "properties": [{
                              "id": "0.aws:runShellScript",
                              "runCommand": ["sudo yum update -y", "sudo yum install -y aws-cfn-bootstrap", "sudo yum install -y awslogs"],
                              "workingDirectory": "/"
                          }]
                      }
                  }
              }
              EOT

  depends_on = [module.ami_baking_linux]
}

resource "aws_ssm_document" "windows_ami_baking_document" {
  name          = "my-windows-ami-baking-document"
  document_type = "Command"

  content = <<-EOT
              {
                  "schemaVersion": "2.2",
                  "description": "Document to update and bake AMI with the latest patches for Windows instances",
                  "parameters": {},
                  "runtimeConfig": {
                      "aws:runPowerShellScript": {
                          "properties": [{
                              "id": "0.aws:runPowerShellScript",
                              "runCommand": ["Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force", "Install-Module PSWindowsUpdate -Force", "Get-WindowsUpdate -Install -AcceptAll -AutoReboot"],
                              "workingDirectory": "/"
                          }]
                      }
                  }
              }
              EOT

  depends_on = [module.ami_baking_windows]
}
