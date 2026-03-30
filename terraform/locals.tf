locals {
  environment_tags = {
    Environment = var.environment
  }

  default_tags = {
    Project   = var.project_name
    Owner     = "Ravan"
    ManagedBy = "Terraform"
  }
}
