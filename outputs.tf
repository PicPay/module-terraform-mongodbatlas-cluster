output "cluster_name" {
  value = mongodbatlas_cluster.new_cluster.name
  description = "The name for our cluster"
}

output "mongodb_major_version" {
  value = mongodbatlas_cluster.new_cluster.mongo_db_version
  description = "The major version for Mongo DB"
}

output "srv_address" {
  value = mongodbatlas_cluster.new_cluster.srv_address
  description = "The address for the cluster"
}

output "mongo_uri" {
  value = mongodbatlas_cluster.new_cluster.mongo_uri
  description = "The URI to connect on the cluster"
}

output "mongo_uri_with_options" {
  value = mongodbatlas_cluster.new_cluster.mongo_uri_with_options
  description = "The URI to connect on the cluster with options"
}

output "new_role" {
  value = mongodbatlas_custom_db_role.new_custom_db_role.role_name
  description = "The Role created to this new cluster"
}

output "db_user" {
  value = mongodbatlas_database_user.new_db_user.username
  description = "The DB user created to access this new cluster"
}

output "password" {
  value = mongodbatlas_database_user.new_db_user.password
  description = "The password created to access this new cluster"
}