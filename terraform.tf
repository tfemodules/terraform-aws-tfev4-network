terraform {
  required_version = "~> 0.12.20"
  required_providers {
    aws = {
      version = "~> 2.70"
    }
  }
  experiments = [variable_validation]
}