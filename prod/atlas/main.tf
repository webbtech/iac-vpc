locals {
  state_bucket  = "wt-tf-state-v3-prod"
  state_key     = "atlas.tfstate"
  vpc_state_key = "vpc.tfstate"
  region        = "ca-central-1"
  db_users = {
    "gsales-xls-reports-stage" = { 
      username  = "arn:aws:iam::407205661819:role/gsales-xls-reports-stage-ReportsRole-1CG93B5BRLOX8",
      role_name = "readWrite",
      db_name   = "gales-sales-test"
    }
    "shts-pdf-gen-api-v2" = {
      username  = "arn:aws:iam::407205661819:role/shts-pdf-gen-api-v2-PDFGeneratorRole-GAW2O5Q5WGZ2"
      role_name = "readWrite",
      db_name   = "shorthills"
    }
    "univsales-api-stage" = {
      username  = "arn:aws:iam::407205661819:role/univsales-api-stage-role"
      role_name = "readWrite",
      db_name   = "universal-sales-test"
    }
    "univsales-api-prod" = {
      username  = "arn:aws:iam::407205661819:role/univsales-api-prod-role"
      role_name = "readWrite",
      db_name   = "universal-sales"
    }
    "univsales-quote-pdf-stage" = {
      username  = "arn:aws:iam::407205661819:role/univsales-quote-pdf-stage-LambdaRole-BGA3MBS0F61R"
      role_name = "readWrite",
      db_name   = "universal-sales-test"
    }
    "univsales-quote-pdf-prod" = {
      username  = "arn:aws:iam::407205661819:role/univsales-quote-pdf-prod-LambdaRole-FUM140QX6FPK"
      role_name = "readWrite",
      db_name   = "universal-sales"
    }
    "univsales-wrksht-pdf-stage" = {
      username  = "arn:aws:iam::407205661819:role/univsales-wrksht-pdf-stage-LambdaRole-Y4HIR8ZVJKTF"
      role_name = "readWrite",
      db_name   = "universal-sales-test"
    }
    "univsales-wrksht-pdf-prod" = {
      username  = "arn:aws:iam::407205661819:role/univsales-wrksht-pdf-prod-LambdaRole-WVYQCSBY124U"
      role_name = "readWrite",
      db_name   = "universal-sales"
    }
  }
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
  atlas_project_name      = "AWS Peer"

  atlas_db_user_name_1    = var.atlas_db_user_name_1
  atlas_db_user_passwd_1  = var.atlas_db_user_passwd_1

  cluster_name    = "Peer0"
  cluster_type    = "REPLICASET"

  db_users = local.db_users

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