variable "deploy_rds_db" {
  description = "Enabled deploy rds"
  type        = bool
  default     = false
}

variable "deploy_ec2_instance_db" {
  description = "Create ec2 instance with postgresql db in docker"
  type        = bool
  default     = true
}

variable "path_docker_compose_files" {
  description = "Path in ec2 instance for blockscout files"
  type        = string
  default     = "/opt/blockscout"
}

variable "user" {
  description = "What user to service run as"
  type        = string
  default     = "root"
}

variable "ssh_key_name" {
  description = "Ssh key name"
  type        = string
  default     = ""
}

variable "image_name" {
  description = "OS image mask"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "image_owner" {
  description = "ID of image owner"
  type        = string
  default     = "679593333241"
}

variable "ssh_keys" {
  description = "Create ssh keys"
  type        = map(string)
  default     = {}
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
  default     = "10.105.0.0/16"
}

variable "vpc_private_subnet_cidrs" {
  description = "Not required! You can set custom private subnets"
  type        = list(string)
  default     = null
}

variable "vpc_public_subnet_cidrs" {
  description = "Not required! You can set custom public subnets"
  type        = list(string)
  default     = null
}

variable "enabled_nat_gateway" {
  description = "Nat gateway enabled"
  type        = bool
  default     = true
}

variable "enabled_dns_hostnames" {
  description = "Autocreate dns names for ec2 instance in route53. Required for work with default DB"
  type        = bool
  default     = true
}

variable "blockscout_settings" {
  description = "Settings of blockscout app"
  type = object({
    postgres_password             = optional(string, "postgres")
    postgres_user                 = optional(string, "postgres")
    postgres_host                 = optional(string, "postgres")
    blockscout_docker_image       = optional(string, "blockscout/blockscout-polygon-supernets:5.1.0-prerelease-26e4d6e4")
    rpc_address                   = optional(string, "https://rpc-supertestnet.polygon.technology")
    chain_id                      = optional(string, "93201")
    rust_verification_service_url = optional(string, "https://sc-verifier.aws-k8s.blockscout.com/")
    ws_address                    = optional(string, "")
    visualize_sol2uml_service_url = optional(string, "")
  })
  default = {}
}

variable "tags" {
  description = "Add custom tags for all resources managed by this script"
  type        = map(string)
  default     = {}
}

variable "existed_vpc_id" {
  description = "Required for using existed vpc. ID of VPC"
  type        = string
  default     = ""
}

variable "existed_private_subnets_ids" {
  description = "List of existed id private subnets(For instances)"
  type        = list(string)
  default     = []
}

variable "existed_public_subnets_ids" {
  description = "List of existed if public subnets(For LB)"
  type        = list(string)
  default     = []
}

variable "existed_rds_subnet_group_name" {
  description = "Name of subnet group for RDS deploy"
  type        = string
  default     = ""
}

variable "ssl_certificate_arn" {
  description = "Certificate for ALB"
  type        = string
  default     = ""
}

variable "indexer_instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t2.medium"
}

variable "ui_and_api_instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t2.medium"
}

variable "verifier_instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t2.medium"
}

variable "rds_instance_type" {
  description = "AWS RDS instance type"
  type        = string
  default     = "db.t3.large"
}

variable "rds_allocated_storage" {
  description = "Size of rds storage"
  type        = number
  default     = 20
}

variable "rds_max_allocated_storage" {
  description = "Max size of rds storage"
  type        = number
  default     = 300
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "iam_instance_profile_arn" {
  description = "Amazon Resource Name (ARN) of an existing IAM instance profile. Used when `create_iam_instance_profile_ssm_policy` = `false`"
  type        = string
  default     = null
}

variable "create_iam_instance_profile_ssm_policy" {
  description = "Determines whether an IAM instance profile with SSM policy is created or to use an existing IAM instance profile"
  type        = string
  default     = false
}

variable "verifier_settings" {
  description = "Settings of verifier"
  type = object({
    docker_image                       = optional(string, "ghcr.io/blockscout/smart-contract-verifier:main")
    solidity_fetcher_list_url          = optional(string, "https://solc-bin.ethereum.org/linux-amd64/list.json")
    solidity_refresh_versions_schedule = optional(string, "0 0 * * * * *")
    vyper_fetcher_list_url             = optional(string, "https://raw.githubusercontent.com/blockscout/solc-bin/main/vyper.list.json")
    vyper_refresh_versions_schedule    = optional(string, "0 0 * * * * *")
    sourcify_api_url                   = optional(string, "https://sourcify.dev/server/")
  })
  default = {}
}

variable "verifier_enabled" {
  description = "Verifier deploy"
  type        = bool
  default     = true
}

variable "verifier_replicas" {
  description = "Number of verifier replicas"
  type        = number
  default     = 2
}

variable "visualizer_enabled" {
  description = "Visualizer deploy"
  type        = bool
  default     = true
}

variable "visualizer_replicas" {
  description = "Number of visualizer replicas"
  type        = number
  default     = 2
}

variable "visualizer_docker_image" {
  description = "Docker image of visualizer"
  type        = string
  default     = "ghcr.io/blockscout/visualizer:latest"
}