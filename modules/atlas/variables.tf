

variable "atlas_ip_access_list_2" {
  type = string
  description = "IP for access list 2"
}

variable "atlas_org_id" {
  type = string
  description = "Atlas organization id"
}

variable "atlas_region" {
  type = string
  description = "Atlas region - should correspond to VPC region"
}

variable "atlas_project_name" {
  type = string
  description = "Atlas project name"
}

variable "atlas_provider" {
  type = string
  description = "Atlas provider"
  default = "AWS"
}

variable "atlas_vpc_cidr" {
  type = string
  description = "Atlas VPC CIDR block"
}

variable "atlas_db_user_name_1" {
  type = string
  description = "DB user name for user 1"
}

variable "atlas_db_user_passwd_1" {
  type = string
  description = "DB user password for user 1"
}

variable "auto_scaling_disk_gb_enabled" {
  type = bool
  description = "Flag for auto scaling of disk size"
}

variable "aws_account_id" {
  type = string
  description = "AWS Account id"
}

variable "aws_region" {
  type = string
  description = "AWS Region"
}

variable "db_users" {
  type = map
  description = "A map of db users and dbs "
}

variable "cloud_backup" {
  type = bool
  description = "Cloud back flag"
}

variable "cluster_name" {
  type = string
  description = "Cluster name"
}

variable "cluster_type" {
  type = string
  description = "Cluster type"
}

variable "disk_size_gb" {
  type = number
  description = "Disk size in GB"
}

variable "mongo_db_major_version" {
  type = string
  description = "MongoDB major version"
}

variable "provider_volume_type" {
  type = string
  description = "Provider volume type"
}

variable "provider_instance_size_name" {
  type = string
  description = "Provider instance size name"
}

variable "state_bucket" {
  type = string
  description = "State bucket"
}

variable "vpc_state_key" {
  type = string
  description = "VPC state key"
}