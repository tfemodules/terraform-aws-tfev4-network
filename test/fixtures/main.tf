module "tfe_network" {
  source = "../../"

  vpc_cidr_block        = var.vpc_cidr_block
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  rds_subnets_cidrs     = var.rds_subnets_cidrs

  availability_zones = var.availability_zones

  name_prefix = var.name_prefix
  common_tags = var.common_tags
}

terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      version = "~> 3.0"
    }
  }
}