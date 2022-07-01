locals {
  state_bucket  = "wt-tf-state-v3-prod"
  state_key     = "atlas.tfstate"
  vpc_state_key = "vpc.tfstate"
  region        = "ca-central-1"
}

terraform {
  backend "s3" {
    bucket = "wt-tf-state-v3-prod"
    key    = "atlas.tfstate"
    region = "ca-central-1"
  }
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.13"
}

provider "mongodbatlas" {
  public_key   = var.atlas_api_public_key
  private_key  = var.atlas_api_private_key
}

module "atlas" {
  source = "../../modules/atlas"

  atlas_org_id            = var.atlas_org_id
  atlas_region            = "CA_CENTRAL_1"
  atlas_vpc_cidr          = "192.168.248.0/21"
  atlas_ip_access_list_2  = var.office_ip

  atlas_db_user_name_1    = var.atlas_db_user_name_1
  atlas_db_user_passwd_1  = var.atlas_db_user_passwd_1

  cluster_name    = "Peer0"
  cluster_type    = "REPLICASET"

  disk_size_gb                  = 10
  provider_volume_type          = "STANDARD"
  provider_instance_size_name   = "M10"
  cloud_backup                  = true
  auto_scaling_disk_gb_enabled  = true
  mongo_db_major_version        = "5.0"
  
  aws_region      = local.region
  aws_account_id  = var.aws_account_id

  state_bucket  = local.state_bucket
  vpc_state_key = local.vpc_state_key
}