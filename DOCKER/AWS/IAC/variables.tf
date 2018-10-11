variable "aws_region" {
  description = "AWS region on which the swarm cluster will be setup"
  default = "eu-west-1"
}

variable "ami" {
  description = "CentOS AWS ami"
  default = "ami-0d063c6b"
}

variable "efs_supported" {
  description = "Set to '1' if the AWS region supports EFS, or 0 if not (see https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/)."
}

variable "linux_user" {
  description = "CentOS user"
  default = "centos"
}

variable "windows_user" {
  description = "Windows user"
  default = "Administrator"
}

variable "linux_manager_instance_type" {
  description = "Manager Instance type"
  default = "m4.large"
}

variable "linux_worker_instance_type" {
  description = "Worker Instance type"
  default = "m4.large"
}

variable "linux_dtr_instance_type" {
  description = "DTR Instance type"
  default = "m4.large"
}

variable "windows_worker_instance_type" {
  description = "Windows Worker Instance type"
  default = "m4.large"
}

variable "key_name" {
  description = "AWS Key Pair name"
  default = "ydaniel"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/Users/eggmuffin/.ssh/keys/AWS_Perso/ydaniel.pem"
}

variable "bootstrap_path" {
  description = "Script to install Docker Engine"
  default = "install-docker.sh"
}

variable "remote_ssh_range" {
  description = "Remote IP range authorized to SSH"
  default = "${var.vpc_ip_range}"
}

variable "remote_access_range" {
  description = "Remote IP range authorized to access Docker GUI Components"
  default = "0.0.0.0/0"
}

variable "vpc_ip_range" {
  description = "VPC IP Range"
  default = "172.30.0.0/16"
}

variable "dtr_bucket_name" {
  description = "DTR S3 Bucket Name"
  default = "DTR-Bucket"
}

variable "manager_cluster_size" {
  description = "Number of Manager Nodes"
  default = "1"
}

variable "worker_cluster_size" {
  description = "Number of Worker Nodes"
  default = "1"
}

variable "worker_dtr_cluster_size" {
  description = "Number of DTR Worker Nodes"
  default = "1"
}

variable "windows_worker_cluster_size" {
  description = "Number of Windows Worker Nodes"
  default = "0"
}

variable "max_autoscaled_managers_size" {
  description = "Maximum number of autoscaled manager nodes"
  default = "1"
}

variable "max_autoscaled_workers_size" {
  description = "Maximum number of autoscaled worker nodes"
  default = "1"
}

variable "max_autoscaled_workers_dtr_size" {
  description = "Maximum number of autoscaled DTR worker nodes"
  default = "1"
}

variable "max_autoscaled_windows_workers_size" {
  description = "Maximum number of autoscaled Windows worker nodes"
  default = "0"
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

variable "Linux_dtr_worker_volume_system_size" {
  description = "The system volume size in GB for Linux DTR workers"
  default     = "8"
}

variable "Linux_dtr_worker_volume_data_size" {
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
