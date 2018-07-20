# Produce an inventory that can be read by ansible

# All Windows machines have the same password
data "template_file" "windows_worker_passwords" {
  count    = "${var.windows_ucp_worker_count}"
  template = "${local.windows_password}"
}

# Pass additional options
data "template_file" "extra_opts" {
  template = <<EOF
docker_ucp_license_path=$${ucp_license_path}
docker_ucp_admin_password=$${ucp_admin_password}
EOF

  vars {
    ucp_admin_password = "${local.ucp_admin_password}"
    ucp_license_path   = "${var.ucp_license_path}"
  }
}

module "inventory" {
  # Terraform doesn't allow variables in the path..
  # https://github.com/hashicorp/terraform/issues/1439
  source = "./modules/ansible"

  inventory_file = "${var.ansible_inventory}"

  linux_user               = "${var.linux_user}"
  windows_user             = "${var.windows_user}"
  windows_worker_passwords = "${data.template_file.windows_worker_passwords.*.rendered}"

  linux_ucp_manager_names = "${vsphere_virtual_machine.linux_ucp_manager.*.name}"
  linux_ucp_manager_ips   = "${vsphere_virtual_machine.linux_ucp_manager.*.default_ip_address}"

  linux_dtr_worker_names = "${vsphere_virtual_machine.linux_dtr.*.name}"
  linux_dtr_worker_ips   = "${vsphere_virtual_machine.linux_dtr.*.default_ip_address}"

  linux_worker_names = "${vsphere_virtual_machine.linux_ucp_worker.*.name}"
  linux_worker_ips   = "${vsphere_virtual_machine.linux_ucp_worker.*.default_ip_address}"

  windows_worker_names = "${vsphere_virtual_machine.windows_ucp_worker.*.name}"
  windows_worker_ips   = "${vsphere_virtual_machine.windows_ucp_worker.*.default_ip_address}"

  linux_database_names = "${vsphere_virtual_machine.linux_database.*.name}"
  linux_database_ips   = "${vsphere_virtual_machine.linux_database.*.default_ip_address}"

  linux_build_server_names = "${vsphere_virtual_machine.linux_build_server.*.name}"
  linux_build_server_ips   = "${vsphere_virtual_machine.linux_build_server.*.default_ip_address}"

  windows_database_names = "${vsphere_virtual_machine.windows_database.*.name}"
  windows_database_ips   = "${vsphere_virtual_machine.windows_database.*.default_ip_address}"

  windows_build_server_names = "${vsphere_virtual_machine.windows_build_server.*.name}"
  windows_build_server_ips   = "${vsphere_virtual_machine.windows_build_server.*.default_ip_address}"

  linux_ucp_lb_names = "${vsphere_virtual_machine.linux_ucp_lb.*.name}"
  linux_ucp_lb_ips   = "${vsphere_virtual_machine.linux_ucp_lb.*.default_ip_address}"

  linux_dtr_lb_names = "${vsphere_virtual_machine.linux_dtr_lb.*.name}"
  linux_dtr_lb_ips   = "${vsphere_virtual_machine.linux_dtr_lb.*.default_ip_address}"

  docker_ucp_lb = "${element(vsphere_virtual_machine.linux_ucp_lb.*.default_ip_address, 0)}"
  docker_dtr_lb = "${element(vsphere_virtual_machine.linux_dtr_lb.*.default_ip_address, 0)}"

  infra_stack = "vmware"
  extra_vars  = "${data.template_file.extra_opts.rendered}"
}
