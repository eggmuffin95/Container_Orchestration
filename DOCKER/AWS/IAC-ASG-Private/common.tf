variable "deployment" {
  description = "Deployment Suffix for Object Name"
  default = "ddc"
}

variable "aws_region" {
  description = "AWS region on which the swarm cluster will be setup"
  default = "eu-west-1"
}


variable "windows_user" {
  description = "Windows user"
  default = "Administrator"
}

variable "linux_user" {
  description = "CentOS user"
  default = "centos"
}

variable "windows_admin_password" {
  description = "Windows worker password"
  default     = ""
}

resource "random_string" "windows_password" {
  length  = 16
  special = false

  keepers = {
    # Generate a new password only when a new deployment is defined
    deployment = "${var.deployment}"
  }
}

# 1. generate a random string
# 2. append a known string of mT4! which will satisfy 4 of the password complexity requirements:
#    i.   Contains an uppercase character
#    ii.  Contains a lowercase character
#    iii. Contains a numeric digit
#    iv.  Contains a special character
locals {
  windows_password = "${var.windows_admin_password == "" ? "${random_string.windows_password.result}mT4!" : var.windows_admin_password}"
}

variable "linux_manager_instance_type" {
  description = "Manager Instance type"
  default = "t2.medium"
}

variable "managers_cluster_size" {
  description = "Number of Manager Nodes"
  default = "1"
}

variable "linux_worker_instance_type" {
  description = "Worker Instance type"
  default = "t2.medium"
}

variable "workers_cluster_size" {
  description = "Number of Worker Nodes"
  default = "1"
}

variable "windows_worker_instance_type" {
  description = "Windows Worker Instance type"
  default = "t2.medium"
}

variable "windows_workers_cluster_size" {
  description = "Number of Windows Worker Nodes"
  default = "0"
}

variable "linux_dtr_worker_instance_type" {
  description = "DTR Instance type"
  default = "t2.medium"
}

variable "dtr_workers_cluster_size" {
  description = "Number of DTR Worker Nodes"
  default = "1"
}

variable "docker_ucp_lb" {
  description = "UCP load balancer DNS name"
  default     = ""
}

variable "docker_dtr_lb" {
  description = "DTR load balancer DNS name"
  default     = ""
}

variable "ansible_inventory" {
  description = "Path where the ansible inventory is stored"
  default = "./inventory/1.hosts"
}

variable "ucp_license_path" {
  description = "UCP License path"
  default     = ""
}

variable "ucp_admin_password" {
  description = "UCP Admin password"
  default     = ""
}

resource "random_string" "ucp_password" {
  length  = 12
  special = false

  keepers = {
    # Generate a new password only when a new deployment is defined
    deployment = "${var.deployment}"
  }
}

locals {
  ucp_admin_password = "${var.ucp_admin_password == "" ? "${random_string.ucp_password.result}" : var.ucp_admin_password}"
}
