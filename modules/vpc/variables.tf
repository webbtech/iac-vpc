/* variable "aws_region" {
  description = "AWS Region of service"
  type        = string
} */

variable "azs" {
  description = "availability zone names"
  type    = list(string)
}

variable "cidr" {
  description = "cidr used for vpc network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "default_tags" {
  description = "List of default tags for module"
  type        = map(string)
  default     = {}
}

variable "dhcp_options_domain_name_servers" {
  type = list(string)
  description = "dhcp domain name servers"
}

variable "enable_dhcp_options" {
  type = bool
  description = "Flag to enable dhcp options"
}

variable "enable_dns_hostnames" {
  type = bool
  description = "Flag to enable dns hostnames"
}

variable "enable_dns_support" {
  type = bool
  description = "Flag to enable dns support"
}

variable "enable_ipv6" {
  type = bool
  description = "Flag to enable ipv6"
}

variable "enable_nat_gateway" {
  type = bool
  description = "Flag to enable nat gateway"
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "single_nat_gateway" {
  type = bool
  description = "Flat to identify single nat gateway"
}

variable "svc_name" {
  description = "Name of main service"
  type        = string
}

variable "svc_prefix" {
  description = "Prefix of main service"
  type        = string
}