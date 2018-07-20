variable "aws_region" {
  description = "AWS region on which the swarm cluster will be setup"
  default = "eu-west-1"
}

variable "ami" {
  description = "CentOS AWS ami"
  default = "ami-0d063c6b"
}

variable "instance_type" {
  description = "Instance type"
  default = "m4.large"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/Users/eggmuffin/.ssh/id_rsa.pub"
}

variable "bootstrap_path" {
  description = "Script to install Docker Engine"
  default = "install-docker.sh"
}

variable "remote_ssh_range" {
  description = "Remote IP range authorized to SSH"
  default = "172.30.0.0/16"
}

variable "remote_access_range" {
  description = "Remote IP range authorized to access Docker GUI Components"
  default = "0.0.0.0/0"
}

variable "vpc_ip_range" {
  description = "VPC IP Range"
  default = "172.30.0.0/16"
}

variable "vpc_id" {
  description = "VPC ID"
  default = "vpc-3e04755a"
}

variable "dtr_bucket_name" {
  description = "DTR S3 Bucket Name"
  default = "DTR-Bucket"
}

variable "manager_cluster_size" {
  description = "Number of Manager Nodes"
  default = "3"
}

variable "worker_cluster_size" {
  description = "Number of Worker Nodes"
  default = "3"
}

variable "max_autoscaled_managers_size" {
  description = "Maximum number of autoscaled manager nodes"
  default = "3"
}
