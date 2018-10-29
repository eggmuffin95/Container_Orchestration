variable "ami" {
  description = "CentOS AWS ami"
  default = "ami-0d063c6b"
}

variable "scheme_elb" {
  description = "Chose to deploy ELB in a private network scheme or not"
  default = "false"
}

variable "scheme_subnets" {
  description = "Chose to map subnets with public network scheme or not"
  default = "true"
}

variable "scheme_ec2" {
  description = "Chose to map public ip's on EC2 instances or not"
  default = "true"
}

variable "efs_supported" {
  description = "Set to '1' if the AWS region supports EFS, or 0 if not (see https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/)."
}

variable "efs_performance" {
  description = "Set efs performance to generalPurpose or maxIO"
  default = "generalPurpose"
}

variable "key_name" {
  description = "AWS Key Pair name"
  default = "ydaniel"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/Users/eggmuffin/.ssh/keys/AWS_Perso/ydaniel.pem"
}

variable "remote_ssh_range" {
  description = "Remote IP range authorized to SSH"
  default = "0.0.0.0/0"
}

variable "remote_access_range" {
  description = "Remote IP range authorized to access Docker GUI Components"
  default = "0.0.0.0/0"
}

variable "vpc_ip_range" {
  description = "VPC IP Range"
  default = "172.30.0.0/16"
}

variable "swarm_cidr" {
  description = "Swarm Global IP Range"
  default = "172.30.0.0/22"
}

variable "ucp_cidr" {
  description = "UCP Global IP Range"
  default = "172.30.4.0/22"
}

variable "dtr_cidr" {
  description = "DTR Global IP Range"
  default = "172.30.8.0/22"
}

variable "ext_cidr" {
  description = "External Global IP Range"
  default = "172.30.12.0/22"
}

variable "pub_cidr" {
  description = "Public Global IP Range"
  default = "172.30.16.0/25"
}

variable "dtr_bucket_name" {
  description = "DTR S3 Bucket Name"
  default = "dtr"
}

variable "access_logs_bucket_name" {
  description = "Access Logs S3 Bucket Name"
  default = "access-logs"
}

variable "delete_root_ebs" {
  description = "Chose to delete on instance termination EBS root volume or not"
  default = "true"
}

variable "delete_data_ebs" {
  description = "Chose to delete on instance termination EBS data volume or not"
  default = "true"
}

variable "ebs_optimized" {
  description = "chose to deploy EBS Optimized volume or not"
  default = "false"
}

variable "linux_manager_volume_system_size" {
  description = "The system volume size in GB for Linux managers"
  default     = "8"
}

variable "linux_manager_volume_data_size" {
  description = "The data volume size in GB for Linux managers"
  default     = "10"
}

variable "linux_worker_volume_system_size" {
  description = "The system volume size in GB for Linux workers"
  default     = "8"
}

variable "linux_worker_volume_data_size" {
  description = "The data volume size in GB for Linux workers"
  default     = "10"
}

variable "linux_dtr_worker_volume_system_size" {
  description = "The system volume size in GB for Linux DTR workers"
  default     = "8"
}

variable "linux_dtr_worker_volume_data_size" {
  description = "The data volume size in GB for Linux DTR workers"
  default     = "10"
}

variable "windows_worker_volume_system_size" {
  description = "The system volume size in GB for Windows workers"
  default     = "10"
}

variable "windows_worker_volume_data_size" {
  description = "The data volume size in GB for Windows workers"
  default     = "10"
}

variable "bootstrap_path" {
  description = "Path where the instance user data script is stored"
  default = "./user-data.sh"
}
