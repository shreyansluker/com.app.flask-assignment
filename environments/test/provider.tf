provider "aws" {
  profile = "xalts-assignment"
  region  = var.region
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}