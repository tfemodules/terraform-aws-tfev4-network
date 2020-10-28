output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The id of the VPC which was created."
}

output "public_subnet_ids" {
  value       = values(aws_subnet.public)[*].id
  description = "Ids of the 'public' subents."
}

output "public_subnet_cidr_to_id" {
  value       = { for cidr, id in aws_subnet.public : cidr => id }
  description = "A mapping of the public subent CIRDs to their Ids."
}

output "private_subnet_ids" {
  value       = values(aws_subnet.private)[*].id
  description = "Ids of the private subents."
}

output "private_subnet_cidr_to_id" {
  value       = { for cidr, id in aws_subnet.private : cidr => id }
  description = "A mapping of the private subent CIRDs to their Ids."
}

output "rds_subnet_ids" {
  value       = values(aws_subnet.rds)[*].id
  description = "Ids of the private subents."
}

output "rds_subnet_cidr_to_id" {
  value       = { for cidr, id in aws_subnet.rds : cidr => id }
  description = "A mapping of the RDS subent CIRDs to their Ids."
}

output "nat_gateway_public_ip" {
  value       = aws_nat_gateway.gw.public_ip
  description = "The public IP of the NAT gateway."
}