terraform {
  required_version = "1.13.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=6.19.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  // region = "ap-northeast-2"
  // access_key = "value"
  // secret_key = "value"
}
