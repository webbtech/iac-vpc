
#
# Data sources to get VPC and default security group details
#

data "aws_vpc" "default" {
  id = module.vpc.vpc_id
}

/* data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
} */

/* resource "aws_security_group" "allow-ssh" {
  vpc_id      = module.main-vpc.vpc_id
  name        = "allow-ssh"
  description = "security group that allows tcp traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # tags = {
  #   Name         = "allow-open-ssh"
  #   Terraform    = "true"
  # }
  tags = merge(
    {
      Name      = "allow-open-ssh"
      Terraform = "true"
    },
    var.DEFAULT_TAGS
  )
} */

/* module "http_sg" {
  source  = "terraform-aws-modules/security-group/aws/modules/http-80"
  version = "~> 3.0"

  name        = "http-80-sg"
  description = "Security group with HTTP ports open for everybody"
  vpc_id      = module.main-vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
    # Allow ingress rules to be accessed only within current VPC
  # ingress_cidr_blocks = [data.aws_vpc.default.cidr_block]

  # Allow all rules for all protocols
  egress_rules = ["http-80-tcp"]

  tags = merge(
    {
      # Name = format("%s-%s-http", var.svc_prefix, var.svc_name)
      Name = "allow-open-http"
    },
    var.DEFAULT_TAGS
  )
} */

module "https_443_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/https-443"
  version = "~> 3.0"

  name = "https-443-sg"
  description = "Security group with HTTPS ports open for everybody"
  # vpc_id      = module.vpc.vpc_id
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["https-443-tcp"]

  tags = merge(
    {
      Name = format("%s-%s-https", var.svc_prefix, var.svc_name)
    },
    var.default_tags
  )
}