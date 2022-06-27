# terraform docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc

module "main-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "wt-vpc-v2"
  cidr = "10.0.0.0/16"

  azs                 = ["${var.AWS_REGION}a", "${var.AWS_REGION}b", "${var.AWS_REGION}d"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
 
  enable_nat_gateway = false
  enable_vpn_gateway = false

  enable_dhcp_options = true
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  enable_dns_hostnames = true

  tags = merge(
    {
      Terraform = "true"
    },
    var.DEFAULT_TAGS
  )
}

