# TFEv4 Network

Sets up network resources for TFEv4 deployment according to the [reference architecture](https://www.terraform.io/docs/enterprise/before-installing/reference-architecture/aws.html#infrastructure-diagram).

The module will create

* VPC
* Internet Gateway
* Two "public" subnets in different availability zones.
* NAT Gateway, placed in one of the "public" subnets.
* Two "private" subnets placed in the same availability zones as the "public" ones. The outgoing Internet traffic is routed via the NAT gateway. Incoming Internet traffic is not allowed.
* (optional) Two "rds" subnets placed in the same availability zones as the "public" and "private" ones. These subnets do not have any routing to the Internet.

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

## Example Module Declaration

An example of how the module can be used.

```hcl
module "tfe_network" {
  source = "git::https://github.com/tfemodules/terraform-aws-tfev4-network.git"

  vpc_cidr_block        = "172.31.255.0/24"
  public_subnets_cidrs  = ["172.31.255.0/28", "172.31.255.16/28"]
  private_subnets_cidrs = ["172.31.255.32/28", "172.31.255.48/28"]
  rds_subnets_cidrs     = ["172.31.255.64/28", "172.31.255.80/28"]

  availability_zones = []

  name_prefix = "tfe-network-example-"
  common_tags = {
    project = "tfe-network-example"
  }
}
```

## Testing

Tests for the module are set up using `kitchen` and `kitchen-terraform` to run `inspec` tests.

Terraform variables which control the resources created during the test are set up in `test/fixtures/test.tfvars` file

**Note:** The current tests are intended as a place holder for more in-depth checks. Only the bare minimum of the module functionality is tested, almost equivalent to simply running `terraform apply` and verifying that the run is successful.

### Prerequisites

To run the tests you will need the following

* Have Ruby installed, version `~> 2.7.2`. It is recommended to use a ruby versions manager like `rbenv` and not your system ruby installation.
* Have the Ruby Gems specified in the `Gemfile` file installed. It is recommended to use `bundler`.

  ```bash
  gem install bundler
  bundle install
  ```
* Have Terraform installed, version `>= 0.13`

### Running tests

* Set up the credentials for the AWS provider as described [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication). For example

  ```bash
  export AWS_ACCESS_KEY_ID=<YOUR AWS ACCESS KEY ID>
  export AWS_SECRET_ACCESS_KEY=<YOUR AWS SECRET KEY>
  ```
* Set up the AWS region to use.

  ```bash
  export AWS_REGION=<AWS REGION>
  ```
* (optional) Adjust Terraform input variables in `test/fixtures/test.tfvars`
* Use `kitchen` to execute the tests
  * Converge the testing environment.

  ```bash
  bundle exec kitchen converge
  ```

  * Execute the tests.

  ```bash
  bundle exec kitchen verify
  ```

  * Destroy the testing environment.

  ```bash
  bundle exec kitchen destroy
  ```
