provider "aws" {
  region = var.region
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principal {
      service = "ec2.amazonaws.com"
    }
  }
}

resource "aws_iam_role" "example" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags = {
    CreatedBy = "Terraform"
  }
}

resource "aws_iam_role_policy" "s3_policy" {
  name   = "${var.iam_role_name}_s3_access"
  role   = aws_iam_role.example.id
  policy = data.aws_iam_policy_document.s3_access.json
}