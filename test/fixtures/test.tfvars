aws_region = "eu-central-1"

vpc_cidr_block        = "172.31.255.0/24"
public_subnets_cidrs  = ["172.31.255.0/28", "172.31.255.16/28"]
private_subnets_cidrs = ["172.31.255.32/28", "172.31.255.48/28"]
rds_subnets_cidrs     = ["172.31.255.64/28", "172.31.255.80/28"]

name_prefix = "tfe-network-kitchen-test-"
common_tags = {
  project = "tfe-network-kitchen-test"
}