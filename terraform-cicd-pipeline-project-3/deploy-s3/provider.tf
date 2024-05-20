# Terraform settings configuration
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.50.0"
    }
  }
}

# Provider configuration
provider "aws" {
  region = "us-east-1"
}
