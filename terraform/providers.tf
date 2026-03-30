# provider
provider "aws" {
  region = "us-east-1"
}


# terraform state

terraform {
  backend "s3" {
    bucket       = "state-terraform-infrastructure-ecs-aws-ravan"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
