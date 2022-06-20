# example for this found at: https://github.com/mongodb/terraform-provider-mongodbatlas/blob/aec862a58a14dde67033542b1273da2738d91494/examples/MongoDB-Atlas-AWS-VPC-Peering/atlas.tf
resource "mongodbatlas_cluster" "cluster-vpc-peer-demo" {
  project_id   = var.ATLAS_PROJECT_ID
  name         = "cluster-vpc-peer-demo"
  num_shards   = 1

  replication_factor           = 3
  # provider_backup_enabled      = false
  cloud_backup                 = false
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "5.0"

  //Provider Settings "block"
  provider_name               = var.ATLAS_PROVIDER
  disk_size_gb                = 10
  provider_disk_iops          = 100
  provider_volume_type        = "STANDARD"
  provider_instance_size_name = "M10"
  provider_region_name        = var.ATLAS_REGION
}
