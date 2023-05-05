
provider "aws" {
  region = "us-east-1" # Replace with the region you want to use
}

resource "aws_iam_user" "example" {
  name = "my-iam-user" # Replace with the name you want to use
}

resource "aws_iam_access_key" "example" {
  user = aws_iam_user.example.name
}


