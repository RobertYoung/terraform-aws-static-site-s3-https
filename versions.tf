terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
      configuration_aliases = [aws.useast1]
    }
  }
  required_version = ">= 0.13"
}
