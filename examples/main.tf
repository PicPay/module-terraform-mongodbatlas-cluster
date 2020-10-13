module "mongodb_atlas_rs_aws" {
    source                          = "../"
    project_id                      = "19pl185d9705058372402b3v"
    provider_instance_size_name     = "M10"
    disk_size_gb                    = 100
    provider_disk_iops              = 300
    provider_volume_type            = "STANDARD"
    auto_scaling_disk_gb_enabled    = true
    backup_enabled                  = true
    pit_enabled                     = true
    mongo_db_major_version          = "4.0"
    replication_specs_config        = [
        {
            region_name         = "US-EAST-1"
            electable_nodes     = 3
            priority            = 7
            read_only_nodes     = 0
            analytics_nodes     = 0
        }
    ]
    role_name     = "tfTestClusterMultiRegion"
    database_name = "tfDb"
    username      = "tf_teste_aws_rs"
    password      = "2asd3sGy7K"

    environment   = "lab"
    name          = "ec2_teste"
    squad         = "InfraCore"
    costcenter    = "1462"
    tribe         = "Infra Cloud"
}