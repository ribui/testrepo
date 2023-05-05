provider "aws" {
  region = "us-east-1" # Replace with the region you want to use
}

resource "aws_ecr_repository" "example" {
  name = "my-ecr-repo" # Replace with the name you want to use

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  lifecycle {
    prevent_destroy = false # Set to true to prevent accidental deletion
  }
}

