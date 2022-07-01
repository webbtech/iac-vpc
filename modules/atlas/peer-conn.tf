# MongoDB ATLAS Network Container
resource "mongodbatlas_network_container" "atlas-network-container" {
    project_id       = mongodbatlas_project.aws_atlas.id
    atlas_cidr_block = var.atlas_vpc_cidr
    provider_name    = var.atlas_provider
    region_name      = var.atlas_region
}

# MongoDB ATLAS VPC Peer Conf
resource "mongodbatlas_network_peering" "atlas-network-peering" {
  accepter_region_name    = var.aws_region
  project_id              = mongodbatlas_project.aws_atlas.id
  container_id            = mongodbatlas_network_container.atlas-network-container.container_id
  provider_name           = var.atlas_provider
  route_table_cidr_block  = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
  vpc_id                  = data.terraform_remote_state.vpc.outputs.vpc_id
  aws_account_id          = var.aws_account_id
}
 
#IP Whitelist on ATLAS side
resource "mongodbatlas_project_ip_access_list" "atlas-ip-access-list-1" {
  project_id = mongodbatlas_project.aws_atlas.id
  cidr_block = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
  comment    = "CIDR block for AWS Public Subnet Access for Atlas"
}

resource "mongodbatlas_project_ip_access_list" "atlas-ip-access-list-2" {
  project_id = mongodbatlas_project.aws_atlas.id
  ip_address = var.atlas_ip_access_list_2
  comment    = "Office IP Address"
}

#AWS VPC Peer Conf
resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = mongodbatlas_network_peering.atlas-network-peering.connection_id
  auto_accept               = true
}

data "aws_vpc_peering_connection" "vpc-peering-conn-ds" {
  vpc_id      = mongodbatlas_network_peering.atlas-network-peering.atlas_vpc_name 
  cidr_block  = var.atlas_vpc_cidr
  peer_region = var.atlas_region
}

data "aws_route_table" "vpc-public-subnet-1-ds" {
  # subnet_id = element(data.terraform_remote_state.vpc.outputs.public_subnets, 0) # Public Subnet 1
  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnets[0] # Public Subnet 1
}

# VPC Peer Device to ATLAS Route Table Association on AWS
resource "aws_route" "aws_peer_to_atlas_route_1" {
  route_table_id            = data.aws_route_table.vpc-public-subnet-1-ds.id
  destination_cidr_block    = var.atlas_vpc_cidr
  vpc_peering_connection_id = data.aws_vpc_peering_connection.vpc-peering-conn-ds.id
}
