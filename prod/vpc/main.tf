locals {
  aws_cidr_block          = "10.0.0.0/16"
  bill_to                 = "webbtech"
  environment             = "prod"
  prefix                  = "wt-v3"
  region                  = "ca-central-1"
  ssh_ingress_cidr_blocks = ["72.38.68.30/32"]
  state_bucket            = "wt-tf-state-v3-prod"
  state_key               = "vpc.tfstate"
  svc                     = "vpc"
  default_tags = {
    BillTo      = "webbtech"
    Environment = "prod"
    Owner       = "webbtech"
    Project     = "wt-v3-prod"
    Terraform   = "true"
  }
}

terraform {
  backend "s3" {
    bucket = "wt-tf-state-v3-prod"
    key    = "vpc.tfstate"
    region = "ca-central-1"
  }
}

provider "aws" {
  # profile = "default"
  region      = local.region
  access_key  = var.aws_access_key
  secret_key  = var.aws_secret_key
}

module "main_vpc" {
  source = "../../modules/vpc"

  cidr = local.aws_cidr_block

  azs = ["${local.region}a", "${local.region}b", "${local.region}d"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_ipv6 = true

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dhcp_options = true
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  default_tags         = local.default_tags
  svc_prefix           = local.prefix
  svc_name             = local.svc
}

