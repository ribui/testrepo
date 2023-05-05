provider "aws" {
  region = "us-east-1"   # Update with the desired region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "mybucketname2023"   # Update with the desired bucket name
  acl    = "private"          # Specify the bucket's access control list (ACL)
}

