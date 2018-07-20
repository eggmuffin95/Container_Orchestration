provider "vsphere" {
  version              = ">= 1.2"
  user                 = "${var.vsphere_user}"
  password             = "${var.vsphere_password}"
  vsphere_server       = "${var.vsphere_server}"
  allow_unverified_ssl = "${var.vsphere_unverified_ssl}"
}
