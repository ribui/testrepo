
# Configure AWS provider
provider "aws" {
  region = "us-east-1"
}

# Provision an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "example_key"
  
  tags = {
    Name = "Example Instance"
  }
}
