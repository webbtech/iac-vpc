# example for this found at: https://github.com/mongodb/terraform-provider-mongodbatlas/blob/aec862a58a14dde67033542b1273da2738d91494/examples/MongoDB-Atlas-AWS-VPC-Peering/atlas.tf

resource "mongodbatlas_project" "aws_atlas" {
  name   = "AWS Peer"
  org_id = var.ATLAS_ORG_ID
}
resource "mongodbatlas_cluster" "cluster-vpc-peer-demo" {
  project_id   = mongodbatlas_project.aws_atlas.id
  name         = "Peer0"
  cluster_type = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = var.ATLAS_REGION
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }

  cloud_backup                 = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "5.0"

  //Provider Settings "block"
  provider_name               = var.ATLAS_PROVIDER
  disk_size_gb                = 10
  provider_disk_iops          = 100
  provider_volume_type        = "STANDARD"
  provider_instance_size_name = "M10"
}
