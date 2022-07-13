# example for this found at: https://github.com/mongodb/terraform-provider-mongodbatlas/blob/aec862a58a14dde67033542b1273da2738d91494/examples/MongoDB-Atlas-AWS-VPC-Peering/atlas.tf

# terraform docs: https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs

terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket
    key     = var.vpc_state_key
    region  = var.aws_region
  }
}

data "aws_vpc" "default" {
  id = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "mongodbatlas_project" "aws_atlas" {
  name   = var.atlas_project_name
  org_id = var.atlas_org_id
}

resource "mongodbatlas_cluster" "cluster-vpc-peer-demo" {
  project_id   = mongodbatlas_project.aws_atlas.id
  name         = var.cluster_name
  cluster_type = var.cluster_type
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = var.atlas_region
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }

  cloud_backup                 = var.cloud_backup
  auto_scaling_disk_gb_enabled = var.auto_scaling_disk_gb_enabled
  mongo_db_major_version       = var.mongo_db_major_version

  // Provider Settings "block"
  provider_name               = var.atlas_provider
  disk_size_gb                = var.disk_size_gb
  provider_volume_type        = var.provider_volume_type
  provider_instance_size_name = var.provider_instance_size_name
}
