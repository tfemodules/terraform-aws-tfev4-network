output "vpc_id" {
  value       = module.tfe_network.vpc_id
  description = "The id of the VPC which was created."
}

output "public_subnet_ids" {
  value       = module.tfe_network.public_subnet_ids
  description = "Ids of the 'public' subnets."
}

output "public_subnet_cidr_to_id" {
  value       = module.tfe_network.public_subnet_cidr_to_id
  description = "A mapping of the public subnets CIDRs to their Ids."
}

output "private_subnet_ids" {
  value       = module.tfe_network.private_subnet_ids
  description = "Ids of the private subnets."
}

output "private_subnet_cidr_to_id" {
  value       = module.tfe_network.private_subnet_cidr_to_id
  description = "A mapping of the private subnets CIDRs to their Ids."
}

output "rds_subnet_ids" {
  value       = module.tfe_network.rds_subnet_ids
  description = "Ids of the RDS subnets."
}

output "rds_subnet_cidr_to_id" {
  value       = module.tfe_network.rds_subnet_cidr_to_id
  description = "A mapping of the RDS subnets CIDRs to their Ids."
}

output "nat_gateway_public_ip" {
  value       = module.tfe_network.nat_gateway_public_ip
  description = "The public IP of the NAT gateway."
}