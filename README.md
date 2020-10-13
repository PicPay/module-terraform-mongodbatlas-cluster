# terraform-mongodbatlas-cluster

Terraform Module for provisioning a cluster at mongodb atlas.

Included features:
* Automatically create a new cluster
* Automatically create a role
* Automatically create a user and password for the cluster db

#### IMPORTANT
* Free tier cluster creation (M0) is not supported via API or by this Provider.
* Shared tier clusters (M2, M5) cannot be upgraded to higher tiers via API or by this Provider.
* Changes to cluster configurations can affect costs. Before making changes, please see https://docs.atlas.mongodb.com/billing/.

---

## Usage


**IMPORTANT:** The `master` branch is used in `source` just as an example. In your code, do not pin to `master` because there may be breaking changes between releases.
Instead pin to the release tag (e.g. `?ref=tags/x.y.z`) of one of our [latest releases](https://github.com/PicPay/module-terraform-mongodbatlas-cluster/releases).


Note: add `${var.ssh_key_pair}` private key to the `ssh agent`.

Include this repository as a module in your existing terraform code.

### Simple example:
```hcl
module "mongodb_atlas_rs_aws" {
    source                          = "git::https://github.com/PicPay/module-terraform-mongodbatlas-cluster.git?ref=master"
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
```


## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| mongodbatlas | ~> 0.4 |
| null | ~> 0.1 |
| template | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| mongodbatlas | ~> 0.4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tag\_map | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| application | application, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| auto\_scaling\_disk\_gb\_enabled | Specifies whether disk auto-scaling is enabled. The default is true. Set to true to enable disk auto-scaling. Set to false to disable disk auto-scaling. | `bool` | `true` | no |
| backup\_enabled | Legacy Backup - Set to true to enable Atlas legacy backups for the cluster. Important - MongoDB deprecated the Legacy Backup feature. Clusters that use Legacy Backup can continue to use it. MongoDB recommends using Cloud Backups. Any net new Atlas clusters of any type do not support this parameter. These clusters must use Cloud Backup, provider\_backup\_enabled, to enable Cloud Backup. If you create a new Atlas cluster and set backup\_enabled to true, the Provider will respond with an error. This change doesn’t affect existing clusters that use legacy backups. Set to false to disable legacy backups for the cluster. Atlas deletes any stored snapshots. The default value is false. M10 and above only. | `bool` | `true` | no |
| bu | Set to PicPay since is the only that we have | `string` | `"PicPay"` | no |
| context | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | <pre>object({<br>    enabled             = bool<br>    application           = string<br>    environment         = string<br>    squad               = string<br>    terraform           = string<br>    name                = string<br>    bu                  = string<br>    costcenter          = string<br>    tribe               = string<br>    delimiter           = string<br>    attributes          = list(string)<br>    tags                = map(string)<br>    additional_tag_map  = map(string)<br>    regex_replace_chars = string<br>    label_order         = list(string)<br>    id_length_limit     = number<br>  })</pre> | <pre>{<br>  "additional_tag_map": {},<br>  "application": null,<br>  "attributes": [],<br>  "bu": "PicPay",<br>  "costcenter": null,<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_order": [],<br>  "name": null,<br>  "regex_replace_chars": null,<br>  "squad": null,<br>  "tags": {},<br>  "terraform": "true",<br>  "tribe": null<br>}</pre> | no |
| costcenter | Set the cost center, see at https://picpay.atlassian.net/wiki/spaces/IC/pages/958530159/PicPay+-+Centro+de+Custos | `string` | `null` | no |
| database\_name | Database on which the inherited role is granted. | `string` | `null` | no |
| delimiter | Delimiter to be used between `bu`, `environment`, `squad`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| disk\_size\_gb | Capacity, in gigabytes, of the host’s root volume. Increase this number to add capacity, up to a maximum possible value of 4096 (i.e., 4 TB). This value must be a positive integer. The minimum disk size for dedicated clusters is 10GB for AWS and GCP. If you specify diskSizeGB with a lower disk size, Atlas defaults to the minimum disk size value. Note: The maximum value for disk storage cannot exceed 50 times the maximum RAM for the selected cluster. If you require additional storage space beyond this limitation, consider upgrading your cluster to a higher tier. Cannot be used with clusters with local NVMe SSDs Cannot be used with Azure clusters | `number` | `10` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| environment | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| id\_length\_limit | Limit `id` to this many characters.<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| label\_order | The naming order of the id output and Name tag.<br>Defaults to ["bu", "environment", "squad", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| mongo\_db\_major\_version | Version of the cluster to deploy. Atlas supports the following MongoDB versions for M10+ clusters: 3.6, 4.0, or 4.2. You must set this value to 4.2 if provider\_instance\_size\_name is either M2 or M5. | `string` | `"4.0"` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| password | User's initial password. A value is required to create the database user, however the argument but may be removed from your Terraform configuration after user creation without impacting the user, password or Terraform management. IMPORTANT --- Passwords may show up in Terraform related logs and it will be stored in the Terraform state file as plain-text. Password can be changed after creation using your preferred method, e.g. via the MongoDB Atlas UI, to ensure security. If you do change management of the password to outside of Terraform be sure to remove the argument from the Terraform configuration so it is not inadvertently updated to the original password. | `string` | `null` | no |
| pit\_enabled | Flag that indicates if the cluster uses Continuous Cloud Backup. If set to true, provider\_backup\_enabled must also be set to true. | `bool` | `true` | no |
| project\_id | The unique ID for the project to create the database user. | `string` | n/a | yes |
| provider\_disk\_iops | The maximum input/output operations per second (IOPS) the system can perform. The possible values depend on the selected provider\_instance\_size\_name and disk\_size\_gb. | `number` | `100` | no |
| provider\_instance\_size\_name | Atlas provides different instance sizes, each with a default storage capacity and RAM size. The instance size you select is used for all the data-bearing servers in your cluster. See (https://docs.atlas.mongodb.com/reference/api/clusters-create-one/) Create a Cluster providerSettings.instanceSizeName for valid values and default resources. Note free tier (M0) creation is not supported by the Atlas API and hence not supported by this provider.). Default to M10 | `string` | `"M10"` | no |
| provider\_volume\_type | The type of the volume. The possible values are: STANDARD and PROVISIONED. PROVISIONED required if setting IOPS higher than the default instance IOPS. | `string` | `"STANDARD"` | no |
| regex\_replace\_chars | Regex to replace chars with empty string in `bu`, `environment`, `squad` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| replication\_specs\_config | Lista de maps para configuração do cluster em cada região. | `list` | n/a | yes |
| squad | squad, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| terraform | Set to true | `bool` | `true` | no |
| tribe | Set the tribe, see at https://picpay.atlassian.net/wiki/spaces/U/pages/681738929/Estrutura+de+tribos+-+PicPay | `string` | `null` | no |
| username | Username for authenticating to MongoDB. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_name | The name for our cluster |
| db\_user | The DB user created to access this new cluster |
| mongo\_uri | The URI to connect on the cluster |
| mongo\_uri\_with\_options | The URI to connect on the cluster with options |
| mongodb\_major\_version | The major version for Mongo DB |
| new\_role | The Role created to this new cluster |
| password | The password created to access this new cluster |
| srv\_address | The address for the cluster |

