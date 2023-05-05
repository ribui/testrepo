
# Configure AWS provider
provider "aws" {
  region = "us-east-1"
}

# Provision an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0889a44b331db0194" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "example_key"
  
  tags = {
    Name = "Example Instance"
  }
}
