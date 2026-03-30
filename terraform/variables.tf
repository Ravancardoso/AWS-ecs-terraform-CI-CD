variable "aws_region" {
  description = "AWS Region to deploy the resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g. dev, stag, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name used for tagging and prefixing"
  type        = string
  default     = "ecs-aws"
}

variable "state_bucket_name" {
  description = "The name of the S3 bucket for Terraform State"
  type        = string
  default     = "state-terraform-infrastructure-ecs-aws-ravan"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}


# CI/CD - GitLab
variable "gitlab_project_path" {
  description = "GitLab project path for OIDC Role (e.g. user/repo)"
  type        = string
  default     = "ravan/aws-ecs-terraform-CI-CD"
}

# Monitoring - Datadog
variable "datadog_external_id" {
  description = "External ID provided by Datadog for AWS Integration"
  type        = string
  sensitive   = true
  default     = "" # Replace with your real ID
}
