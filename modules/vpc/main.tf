
module "vpc" {
  
  // docs: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
  source              = "terraform-aws-modules/vpc/aws"

  name                = format("%s-%s", var.svc_prefix, var.svc_name)
  cidr                = var.cidr

  azs                 = var.azs
  private_subnets     = var.private_subnets
  public_subnets      = var.public_subnets

  enable_ipv6         = var.enable_ipv6

  enable_nat_gateway  = var.enable_nat_gateway
  single_nat_gateway  = var.single_nat_gateway
  
  enable_dhcp_options = var.enable_dhcp_options
  dhcp_options_domain_name_servers = var. dhcp_options_domain_name_servers

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    {
      Name = format("%s-%s", var.svc_prefix, var.svc_name)
    },
    var.default_tags,
  )

  public_subnet_tags = merge(
    {
      Name = format("%s-%s-public", var.svc_prefix, var.svc_name)
    },
    var.default_tags,
  )

  private_subnet_tags = merge(
    {
      Name = format("%s-%s-private", var.svc_prefix, var.svc_name)
    },
    var.default_tags,
  )

  public_route_table_tags = merge(
    {
      Name = format("%s-%s-public", var.svc_prefix, var.svc_name)
    },
    var.default_tags,
  )

  private_route_table_tags = merge(
    {
      Name = format("%s-%s-private", var.svc_prefix, var.svc_name)
    },
    var.default_tags,
  )

  nat_eip_tags = merge(
    {
      Name = format("%s-%s", var.svc_prefix, var.svc_name)
    },
    var.default_tags,
  )

  vpc_tags =  merge(
    {
      Name = format("%s-%s", var.svc_prefix, var.svc_name)
    },
    var.default_tags,
  )

  # Network ACL
  # These don't appear to be working...
  default_network_acl_name = format("%s-%s", var.svc_prefix, var.svc_name)
  default_network_acl_tags = merge(
    {
      Name = format("%s-%s", var.svc_prefix, var.svc_name)
    },
    var.default_tags,
  )

  # Default security group
  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress = []
  default_security_group_tags =  merge(
    {
      Name = "default-sg"
    },
    var.default_tags,
  )

}
