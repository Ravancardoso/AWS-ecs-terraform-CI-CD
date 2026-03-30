# ---------------------------------------------------------------------------------------------------------------------
# AMAZON S3
# ---------------------------------------------------------------------------------------------------------------------

# Allows configuring public access block settings at the account level for Amazon S3.
resource "aws_s3_account_public_access_block" "block_account_public_access" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


#bucket state terraform

resource "aws_s3_bucket" "state_terraform_infrastructure" {
  bucket = var.state_bucket_name
  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "ecs-aws-s3-dev"
    }
  )
}

# versionament
resource "aws_s3_bucket_versioning" "state_terraform_infrastructure_versioning" {
  bucket = aws_s3_bucket.state_terraform_infrastructure.bucket

  versioning_configuration {
    status = "Suspended"
  }
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}
