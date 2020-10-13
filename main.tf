resource "mongodbatlas_cluster" "new_cluster" {
    project_id                          = var.project_id
    name                                = module.this.id
    
    provider_name                       = "AWS"
    cluster_type                        = "REPLICASET"
    num_shards                          = 1

    provider_instance_size_name         = var.provider_instance_size_name
    disk_size_gb                        = var.disk_size_gb
    provider_disk_iops                  = var.provider_disk_iops
    provider_volume_type                = var.provider_volume_type
    auto_scaling_disk_gb_enabled        = var.auto_scaling_disk_gb_enabled

    provider_backup_enabled             = var.backup_enabled
    pit_enabled                         = var.pit_enabled
    
    mongo_db_major_version              = var.mongo_db_major_version


    replication_specs {
            num_shards          = 1
    
        dynamic "regions_config" {
            for_each    = var.replication_specs_config

            content {
                region_name         = regions_config.value["region_name"]
                electable_nodes     = regions_config.value["electable_nodes"]
                priority            = regions_config.value["priority"]
                read_only_nodes     = lookup(regions_config.value, "read_only_nodes", 0)
                analytics_nodes     = lookup(regions_config.value, "analytics_nodes", 0)
            }
        }
    }
}


resource "mongodbatlas_custom_db_role" "new_custom_db_role" {
    project_id          = var.project_id
    role_name           = module.this.id

    actions {
        action      = "FIND"
        resources {
            database_name   = var.database_name
        }
    }
    actions {
        action      = "INSERT"
        resources {
            database_name   = var.database_name
        }
    }
    actions {
        action      = "REMOVE"
        resources {
            database_name   = var.database_name
        }
    }
    actions {
        action      = "UPDATE"
        resources {
            database_name   = var.database_name
        }
    }
    actions {
        action      = "LIST_COLLECTIONS"
        resources {
            database_name   = var.database_name
        }
    }
    actions {
        action      = "LIST_INDEXES"
        resources {
            database_name   = var.database_name
        }
    }
}


resource "mongodbatlas_database_user" "new_db_user" {
    username                = var.username
    password                = var.password
    project_id              = var.project_id
    auth_database_name      = "admin"

    roles {
        role_name       = mongodbatlas_custom_db_role.new_custom_db_role.role_name
        database_name   = "admin"
    }
}