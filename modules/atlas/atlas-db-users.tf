resource "mongodbatlas_database_user" "db-user" {
  username           = var.atlas_db_user_name_1
  password           = var.atlas_db_user_passwd_1
  auth_database_name = "admin"
  project_id         = mongodbatlas_project.aws_atlas.id
  # roles {
  #   role_name     = "readWrite"
  #   database_name = "admin"
  # }
  roles {
    role_name     = "readWriteAnyDatabase"
    database_name = "admin"
  }
  depends_on = [mongodbatlas_project.aws_atlas]
}