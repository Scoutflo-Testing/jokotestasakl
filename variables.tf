variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to deploy resources in"
}

variable "iam_role_name" {
  type        = string
  default     = "my-s3-role"
  description = "Name of the IAM role"
}

variable "bucket_name" {
  type        = string
  default     = "my-example-bucket"
  description = "Name of the S3 bucket"
}