variable "project_id" {
    type        = string
    description = "The unique ID for the project to create the database user."
}

variable "provider_instance_size_name" {
    type        = string
    description = "Atlas provides different instance sizes, each with a default storage capacity and RAM size. The instance size you select is used for all the data-bearing servers in your cluster. See (https://docs.atlas.mongodb.com/reference/api/clusters-create-one/) Create a Cluster providerSettings.instanceSizeName for valid values and default resources. Note free tier (M0) creation is not supported by the Atlas API and hence not supported by this provider.). Default to M10"
    default     = "M10"
}

variable "disk_size_gb" {
    type        = number
    description = "Capacity, in gigabytes, of the host’s root volume. Increase this number to add capacity, up to a maximum possible value of 4096 (i.e., 4 TB). This value must be a positive integer. The minimum disk size for dedicated clusters is 10GB for AWS and GCP. If you specify diskSizeGB with a lower disk size, Atlas defaults to the minimum disk size value. Note: The maximum value for disk storage cannot exceed 50 times the maximum RAM for the selected cluster. If you require additional storage space beyond this limitation, consider upgrading your cluster to a higher tier. Cannot be used with clusters with local NVMe SSDs Cannot be used with Azure clusters"
    default     = 10
}

variable "provider_disk_iops" {
    type        = number
    description = "The maximum input/output operations per second (IOPS) the system can perform. The possible values depend on the selected provider_instance_size_name and disk_size_gb."
    default     = 100
}

variable "provider_volume_type" {
    type        = string
    description = "The type of the volume. The possible values are: STANDARD and PROVISIONED. PROVISIONED required if setting IOPS higher than the default instance IOPS."
    default     = "STANDARD"
}

variable "auto_scaling_disk_gb_enabled" {
    type        = bool
    description = "Specifies whether disk auto-scaling is enabled. The default is true. Set to true to enable disk auto-scaling. Set to false to disable disk auto-scaling."
    default     = true
}

variable "backup_enabled" {
    type        = bool
    description = "Legacy Backup - Set to true to enable Atlas legacy backups for the cluster. Important - MongoDB deprecated the Legacy Backup feature. Clusters that use Legacy Backup can continue to use it. MongoDB recommends using Cloud Backups. Any net new Atlas clusters of any type do not support this parameter. These clusters must use Cloud Backup, provider_backup_enabled, to enable Cloud Backup. If you create a new Atlas cluster and set backup_enabled to true, the Provider will respond with an error. This change doesn’t affect existing clusters that use legacy backups. Set to false to disable legacy backups for the cluster. Atlas deletes any stored snapshots. The default value is false. M10 and above only."
    default     = true
}

variable "pit_enabled" {
    type        = bool
    description = "Flag that indicates if the cluster uses Continuous Cloud Backup. If set to true, provider_backup_enabled must also be set to true."
    default     = true
}

variable "mongo_db_major_version" {
    type        = string
    description = "Version of the cluster to deploy. Atlas supports the following MongoDB versions for M10+ clusters: 3.6, 4.0, or 4.2. You must set this value to 4.2 if provider_instance_size_name is either M2 or M5."
    default     = "4.0"
}

variable "replication_specs_config" {
    description = "Lista de maps para configuração do cluster em cada região."
    type        = list
}

variable "database_name" {
    type        = string
    description = "Database on which the inherited role is granted."
    default     = null
}

variable "username" {
    type        = string
    description = "Username for authenticating to MongoDB."
    default     = null
}

variable "password" {
    type        = string
    description = "User's initial password. A value is required to create the database user, however the argument but may be removed from your Terraform configuration after user creation without impacting the user, password or Terraform management. IMPORTANT --- Passwords may show up in Terraform related logs and it will be stored in the Terraform state file as plain-text. Password can be changed after creation using your preferred method, e.g. via the MongoDB Atlas UI, to ensure security. If you do change management of the password to outside of Terraform be sure to remove the argument from the Terraform configuration so it is not inadvertently updated to the original password."
    default     = null
}
