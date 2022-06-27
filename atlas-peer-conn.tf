#MongoDB ATLAS Network Container
resource "mongodbatlas_network_container" "atlas-network-container" {
    project_id       = mongodbatlas_project.aws_atlas.id
    atlas_cidr_block = var.ATLAS_VPC_CIDR
    provider_name    = var.ATLAS_PROVIDER
    region_name      = var.ATLAS_REGION
}

#MongoDB ATLAS VPC Peer Conf
resource "mongodbatlas_network_peering" "atlas-network-peering" {
  accepter_region_name   = var.AWS_REGION
  project_id             = mongodbatlas_project.aws_atlas.id
  container_id           = mongodbatlas_network_container.atlas-network-container.container_id
  provider_name          = var.ATLAS_PROVIDER
  route_table_cidr_block = var.AWS_VPC_CIDR
  vpc_id                 = module.main-vpc.vpc_id
  aws_account_id         = var.AWS_ACCOUNT_ID
}
 
#IP Whitelist on ATLAS side
resource "mongodbatlas_project_ip_access_list" "atlas-ip-access-list-1" {
  project_id = mongodbatlas_project.aws_atlas.id
  cidr_block = var.AWS_VPC_CIDR
  comment    = "CIDR block for AWS Public Subnet Access for Atlas"
}

resource "mongodbatlas_project_ip_access_list" "atlas-ip-access-list-2" {
  project_id = mongodbatlas_project.aws_atlas.id
  ip_address = var.ATLAS_IPADDRESS_ACCESS
  comment    = "Office IP Address"
}


#AWS VPC Peer Conf
resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = mongodbatlas_network_peering.atlas-network-peering.connection_id
  auto_accept = true
}

data "aws_vpc_peering_connection" "vpc-peering-conn-ds" {
  vpc_id           = mongodbatlas_network_peering.atlas-network-peering.atlas_vpc_name 
  cidr_block       = var.ATLAS_VPC_CIDR
  peer_region      = var.ATLAS_REGION
}

// This always causes an error when applying, second time around ok...
data "aws_route_table" "vpc-public-subnet-1-ds" {
  subnet_id = element(module.main-vpc.public_subnets, 0) //Public Subnet 1 - us-east-1a
  # subnet_id =  module.main-vpc.public_subnets[0]
  depends_on = [module.main-vpc.public_subnets]
}

#VPC Peer Device to ATLAS Route Table Association on AWS
resource "aws_route" "aws_peer_to_atlas_route_1" {
  route_table_id            = data.aws_route_table.vpc-public-subnet-1-ds.id
  destination_cidr_block    = var.ATLAS_VPC_CIDR
  vpc_peering_connection_id = data.aws_vpc_peering_connection.vpc-peering-conn-ds.id
}
