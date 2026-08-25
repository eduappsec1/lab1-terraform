terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}



resource "aws_security_group" "insecure_ssh" {
  name        = "insecure-ssh"
  description = "Security group intentionally vulnerable"

  ingress {
    description = "SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}



resource "aws_s3_bucket" "data" {
  bucket = "ghscd-iac-security-demo"
}

resource "aws_s3_bucket_public_access_block" "data" {

  bucket = aws_s3_bucket.data.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}



resource "aws_ebs_volume" "data" {
  availability_zone = "us-east-1a"
  size = 10
  encrypted = false
}




resource "aws_iam_policy" "admin_policy" {
  name = "insecure-admin-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}
