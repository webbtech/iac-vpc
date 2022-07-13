#
# Users
# for users see: https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/custom_db_role
# and: https://www.mongodb.com/docs/atlas/security-add-mongodb-users/#built-in-roles
#
resource "mongodbatlas_database_user" "db-user" {
  username           = var.atlas_db_user_name_1
  password           = var.atlas_db_user_passwd_1
  auth_database_name = "admin"
  project_id         = mongodbatlas_project.aws_atlas.id
  roles {
    role_name     = "readWriteAnyDatabase"
    database_name = "admin"
  }
  depends_on = [mongodbatlas_project.aws_atlas]
}

resource "mongodbatlas_database_user" "aws_users" {
  project_id         = mongodbatlas_project.aws_atlas.id
  auth_database_name = "$external"
  aws_iam_type       = "ROLE"

  for_each = var.db_users
  username = each.value.username

  labels {
    key   = "stack"
    value = each.key
  }

  roles {
    role_name = each.value.role_name
    database_name = each.value.db_name
  }
}
