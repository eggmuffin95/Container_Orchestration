#######################
# UCP
#######################

variable "linux_ucp_uninstall_command" {
  description = "Command executed locally before destroying the node. Node name is appended as first parameter."
  default     = ""
}

variable "windows_ucp_uninstall_command" {
  description = "Command executed locally before destroying the node. Node name is appended as first parameter."
  default     = ""
}

#######################
# DTR
#######################

variable "linux_dtr_uninstall_command" {
  description = "Command executed locally before destroying the node. Node name is appended as first parameter."
  default     = ""
}

#######################
# Vsphere
#######################

variable "vsphere_user" {
  default = "administrator@vsphere.local"
}

variable "vsphere_password" {}

variable "vsphere_server" {}

variable "vsphere_datastore" {}

variable "vsphere_datacenter" {
  description = "Datacenter to use. Leave empty to use default."
  default     = ""
}

variable "vsphere_windows_template" {
  description = "Windows template for creating a VM"
  default     = ""
}

variable "vsphere_windows_template_workgroup" {
  description = "Windows workgroup to use for the VMs"
  default     = ""
}

variable "vsphere_windows_database_template" {
  description = "Windows database VM template. Leave empty to use default Windows template."
  default     = ""
}

variable "vsphere_windows_build_server_template" {
  description = "Windows build server VM template. Leave empty to use default Windows template."
  default     = ""
}

variable "vsphere_linux_template" {
  description = "Linux template for creating a VM"
}

variable "vsphere_linux_template_domain" {
  description = "Linux VM's domain name"
}

variable "vsphere_linux_database_template" {
  description = "Linux database VM template. Leave empty to use default Linux template."
  default     = ""
}

variable "vsphere_linux_build_server_template" {
  description = "Linux build server VM template. Leave empty to use default Linux template."
  default     = ""
}

variable "vsphere_linux_load_balancer_template" {
  description = "Linux load balancer VM template. Leave empty to use default Linux template."
  default     = ""
}

variable "vsphere_unverified_ssl" {
  description = "Set to true for self-signed certificates"
  default     = "true"
}

variable "vsphere_linked_clone" {
  description = "Enable to create linked clones of the VM template instead of full clones"
  default     = "true"
}

variable "vsphere_eagerly_scrub" {
  description = "Enable to eagerly scrub"
  default     = "true"
}

variable "vsphere_resource_pool" {
  description = "Resource pool"
  default     = "Resources"
}

variable "vsphere_vm_folder" {
  description = "Path on datacenter to store VMs in. Leave empty to use datacenter default."
  default     = ""
}

# VM settings

variable "vm_ucp_manager_num_cpus" {
  description = "CPUs allocated to VMs"
  default     = "4"
}

variable "vm_ucp_manager_memory" {
  description = "Memory in MB allocated to VMs"
  default     = "16384"
}

variable "vm_ucp_worker_num_cpus" {
  description = "CPUs allocated to VMs"
  default     = "2"
}

variable "vm_ucp_worker_memory" {
  description = "Memory in MB allocated to VMs"
  default     = "8192"
}

variable "vm_dtr_num_cpus" {
  description = "CPUs allocated to VMs"
  default     = "4"
}

variable "vm_dtr_memory" {
  description = "Memory in MB allocated to VMs"
  default     = "16384"
}

variable "vm_network" {
  default = "VM Network"
}

variable "vm_db_num_cpus" {
  description = "CPUs allocated to database VMs"
  default     = "2"
}

variable "vm_db_memory" {
  description = "Memory in MB allocated to database VMs"
  default     = "4096"
}

variable "vm_db_disk_size" {
  description = "Size in GB of additional disk attached to database VMs."
  default     = "40"
}

variable "vm_build_num_cpus" {
  description = "CPUs allocated to build VMs"
  default     = "2"
}

variable "vm_build_memory" {
  description = "Memory in MB allocated to build VMs"
  default     = "8192"
}

variable "vm_build_disk_size" {
  description = "Size in GB of additional disk attached to build server VMs."
  default     = "80"
}

variable "vm_lb_num_cpus" {
  description = "CPUs allocated to load balancer VMs"
  default     = "2"
}

variable "vm_lb_memory" {
  description = "Memory in MB allocated to load balancer VMs"
  default     = "4096"
}
