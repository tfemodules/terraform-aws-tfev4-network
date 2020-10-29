data "aws_availability_zones" "azs" {}

locals {
  azs = length(var.availability_zones) == 0 ? [element(data.aws_availability_zones.azs.names, 0), element(data.aws_availability_zones.azs.names, 1)] : var.availability_zones
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = merge({
    Name = "${var.name_prefix}vpc"
    },
    var.common_tags
  )
}

resource "aws_subnet" "public" {
  for_each          = toset(var.public_subnets_cidrs)
  cidr_block        = each.key
  vpc_id            = aws_vpc.main.id
  availability_zone = local.azs[index(var.public_subnets_cidrs, each.key)]
  tags = merge({
    Name = "${var.name_prefix}public"
    },
    var.common_tags
  )
}

resource "aws_subnet" "private" {
  for_each          = toset(var.private_subnets_cidrs)
  cidr_block        = each.key
  vpc_id            = aws_vpc.main.id
  availability_zone = local.azs[index(var.private_subnets_cidrs, each.key)]
  tags = merge({
    Name = "${var.name_prefix}private"
    },
    var.common_tags
  )
}

resource "aws_subnet" "rds" {
  for_each          = toset(var.rds_subnets_cidrs)
  cidr_block        = each.key
  vpc_id            = aws_vpc.main.id
  availability_zone = local.azs[index(var.rds_subnets_cidrs, each.key)]
  tags = merge({
    Name = "${var.name_prefix}rds"
    },
    var.common_tags
  )
}