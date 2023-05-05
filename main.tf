provider "aws" {
  region = "us-west-2" # Replace with the region you want to use
}

resource "aws_key_pair" "example" {
  key_name = "my-key-pair" # Replace with the name you want to use
}


