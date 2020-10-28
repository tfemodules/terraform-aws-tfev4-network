variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for the VPC to create."
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of two AWS availability zones in which to deploy the infrastructure. If not provided Terraform will use any two zones in the current region."
  default     = []
  validation {
    condition     = length(var.availability_zones) == 0 || length(var.availability_zones) == 2
    error_message = "The 'availability_zones' variable value must be a list with 0 or 2 elements."
  }
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "A list of exactly two CIDRs for the public subnets. The CIDRs must be within the CIDR set for 'vpc_cidr_block'."
  validation {
    condition     = length(var.public_subnets_cidrs) == 2
    error_message = "The 'public_subnets_cidrs' variable value must be a list with exactly 2 elements."
  }
}

variable "private_subnets_cidrs" {
  type        = list(string)
  description = "A list of exactly two CIDRs for the private subnets. The CIDRs must be within the CIDR set for 'vpc_cidr_block'."
  validation {
    condition     = length(var.private_subnets_cidrs) == 2
    error_message = "The 'private_subnets_cidrs' variable value must be a list with exactly 2 elements."
  }
}

variable "rds_subnets_cidrs" {
  type        = list(string)
  description = "A list of 0 or two CIDRs for the RDS subnet group. The CIDRs must be within the CIDR set for 'vpc_cidr_block'."
  default     = []
  validation {
    condition     = length(var.rds_subnets_cidrs) == 0 || length(var.rds_subnets_cidrs) == 2
    error_message = "The 'rds_subnets_cidrs' variable value must be a list with 0 or 2 elements."
  }
}

variable "name_prefix" {
  type        = string
  description = "A string to be used as prefix for generating names of the created resources."
  default     = "tfe-"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to assign to all resources."
  default     = {}
}