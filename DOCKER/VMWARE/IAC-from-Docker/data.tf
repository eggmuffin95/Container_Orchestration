# Data sources

data "vsphere_datacenter" "default_datacenter" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_virtual_machine" "linux_template" {
  name          = "${var.vsphere_linux_template}"
  datacenter_id = "${data.vsphere_datacenter.default_datacenter.id}"
}

data "vsphere_virtual_machine" "windows_template" {
  name          = "${var.vsphere_windows_template}"
  datacenter_id = "${data.vsphere_datacenter.default_datacenter.id}"
}

data "vsphere_virtual_machine" "linux_database_template" {
  name          = "${var.vsphere_linux_database_template == "" ? var.vsphere_linux_template : var.vsphere_linux_database_template}"
  datacenter_id = "${data.vsphere_datacenter.default_datacenter.id}"
}

data "vsphere_virtual_machine" "linux_build_server_template" {
  name          = "${var.vsphere_linux_build_server_template == "" ? var.vsphere_linux_template : var.vsphere_linux_build_server_template}"
  datacenter_id = "${data.vsphere_datacenter.default_datacenter.id}"
}

data "vsphere_virtual_machine" "linux_load_balancer_template" {
  name          = "${var.vsphere_linux_load_balancer_template == "" ? var.vsphere_linux_template : var.vsphere_linux_load_balancer_template}"
  datacenter_id = "${data.vsphere_datacenter.default_datacenter.id}"
}

data "vsphere_virtual_machine" "windows_database_template" {
  name          = "${var.vsphere_windows_database_template == "" ? var.vsphere_windows_template : var.vsphere_windows_database_template}"
  datacenter_id = "${data.vsphere_datacenter.default_datacenter.id}"
}

data "vsphere_virtual_machine" "windows_build_server_template" {
  name          = "${var.vsphere_windows_build_server_template == "" ? var.vsphere_windows_template : var.vsphere_windows_build_server_template}"
  datacenter_id = "${data.vsphere_datacenter.default_datacenter.id}"
}

data "vsphere_datastore" "default_datastore" {
  name          = "${var.vsphere_datastore}"
  datacenter_id = "${data.vsphere_datacenter.default_datacenter.id}"
}

data "vsphere_network" "default_network" {
  name          = "${var.vm_network}"
  datacenter_id = "${data.vsphere_datacenter.default_datacenter.id}"
}

data "vsphere_resource_pool" "default_resource_pool" {
  name          = "${var.vsphere_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.default_datacenter.id}"
}
