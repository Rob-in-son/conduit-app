terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }

        ansible = {
        version = "~> 1.3.0"
        source  = "ansible/ansible"
        }
    }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}