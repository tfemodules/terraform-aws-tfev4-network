output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The id of the VPC which was created."
}

output "public_subnet_ids" {
  value       = values(aws_subnet.public)[*].id
  description = "Ids of the 'public' subnets."
}

output "public_subnet_cidr_to_id" {
  value       = { for cidr, subnet in aws_subnet.public : cidr => subnet.id }
  description = "A mapping of the public subnets CIDRs to their Ids."
}

output "private_subnet_ids" {
  value       = values(aws_subnet.private)[*].id
  description = "Ids of the private subnets."
}

output "private_subnet_cidr_to_id" {
  value       = { for cidr, subnet in aws_subnet.private : cidr => subnet.id }
  description = "A mapping of the private subnets CIDRs to their Ids."
}

output "rds_subnet_ids" {
  value       = values(aws_subnet.rds)[*].id
  description = "Ids of the RDS subnets."
}

output "rds_subnet_cidr_to_id" {
  value       = { for cidr, subnet in aws_subnet.rds : cidr => subnet.id }
  description = "A mapping of the RDS subnets CIDRs to their Ids."
}

output "nat_gateway_public_ip" {
  value       = aws_nat_gateway.gw.public_ip
  description = "The public IP of the NAT gateway."
}