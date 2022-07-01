locals {
  bill_to     = "webbtech"
  bucket_name = "wt-tf-state-v3-prod"
  environment = "prod"
  prefix      = "wt-v3"
  region      = "ca-central-1"
  svc         = "s3"
}

provider "aws" {
  profile = "default"
  region = local.region
}

variable "tags" {
  type = map(string)
  description = "Mapping of tags assigned to resource"
  default = {
    BillTo      = "webbtech"
    Environment = "prod"
    Owner       = "webbtech"
    Project     = "wt-v3-prod"
    Terraform   = "true"
  }
}

resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  acl    = "private"
  tags = merge(
    {
      Name = format("%s-%s-tfstate", local.prefix, local.svc)
    },
    var.tags,
  )
}