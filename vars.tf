variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "ATLAS_PUBLIC_KEY" {
}

variable "ATLAS_PRIVATE_KEY" {
}

variable "ATLAS_PROVIDER" {
  default = "AWS"
}

variable "ATLAS_REGION" {
  default = "CA_CENTRAL_1"
}

variable "AWS_REGION" {
  default = "ca-central-1"
}

variable "AWS_VPC_CIDR" {
  default = "10.0.0.0/16"
}

variable "AWS_ACCOUNT_ID" {
  default = "407205661819"
}

variable "ATLAS_ORG_ID" {
  default = "5bc27763d5ec13daf22b4d44"
}

# variable "ATLAS_PROJECT_ID" {
#   default = "62acc6ba66dd03280895e9bc"
# }

variable "ATLAS_VPC_CIDR" {
  default = "192.168.248.0/21"
}

variable "ATLAS_IPADDRESS_ACCESS" {
  description = "IP Address for project access list"
}

variable "DEFAULT_TAGS" {
  description = "List of default tags for module"
  type        = map(string)
  default     = {
    BillTo      = "webbtech"
    Owner       = "webbtech"
    Environment = "prod"
    Project     = "wt-v3-prod"
  }
}

variable "INSTANCE_TYPE" {
  default = "t2.nano"
}

variable "KEY_NAME" {
  default = "ca-central"
}

# ================= Atlas Users ======================= #
variable "ATLAS_DB_USER" {
  description = "The Atlas db user name"
}

variable "ATLAS_DB_PASSWORD" {
  description = "The Atlas db user password"
}