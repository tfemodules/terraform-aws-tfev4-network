# TFEv4 Network

Sets up network resources for TFEv4 deployment according to the [reference architecture](https://www.terraform.io/docs/enterprise/before-installing/reference-architecture/aws.html#infrastructure-diagram).

The module will create

* VPC
* Internet Gateway
* Two "public" subnets in different availability zones.
* NAT Gateway, placed in one of the "public" subnets.
* Two "private" subnets placed in the same availability zones as the "public" ones. The outgoing Internet traffic is routed via the NAT gateway. Incoming Internet traffic is not allowed.
* (optional) Two "rds" subnets placed in the same availability zones as the "public" and "private" ones. These subnets do not have any routing to the Internet.

Example of how to use the module can be found in the `example/` directory.

## Requirements

The requirements to use the module are:

* Terraform CLI version `>= 0.13`
* Provider AWS version `~> 3.0`

## Input Variables

The input variables available for the module are in the table below.

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| vpc_cidr_block | `string` | | CIDR for the VPC to create. |
| availability_zones | `list(string)` | `[]` | A list of two AWS availability zones in which to deploy the infrastructure. If not provided Terraform will use any two zones in the current region. |
| public_subnets_cidrs | `list(string)` | | A list of exactly two CIDRs for the private subnets. The CIDRs must be within the CIDR set for 'vpc_cidr_block'. |
| private_subnets_cidrs | `list(string)` | | A list of exactly two CIDRs for the private subnets. The CIDRs must be within the CIDR set for 'vpc_cidr_block'. |
| rds_subnets_cidrs | `list(string)` | `[]` | A list of 0 or two CIDRs for the RDS subnet group. The CIDRs must be within the CIDR set for 'vpc_cidr_block'. |
| name_prefix | `string` | | A string to be used as prefix for generating names of the created resources. |
| common_tags | `map(string)` | `{}` | Common tags to assign to all resources. |

## Outputs

The outputs declared by the module are in the table below

| Variable | Type | Description |
|----------|------|-------------|
| vpc_id | `string` | The id of the VPC which was created. |
| public_subnet_ids | `list(string)` | Ids of the 'public' subnets. |
| public_subnet_cidr_to_id | `map(string)` | A mapping of the public subnets CIDRs to their Ids. |
| private_subnet_ids | `list(string)` | Ids of the 'private' subnets. |
| private_subnet_cidr_to_id | `map(string)` | A mapping of the private subnets CIDRs to their Ids. |
| rds_subnet_ids | `list(string)` | Ids of the RDS subnets. |
| rds_subnet_cidr_to_id | `map(string)` | A mapping of the RDS subnets CIDRs to their Ids. |
| nat_gateway_public_ip | `string` | The public IP of the NAT gateway. |
