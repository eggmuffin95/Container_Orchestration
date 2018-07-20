# Produce an inventory that can be read by ansible

data "azurerm_storage_account" "dtr_storage_account" {
  name                = "${azurerm_storage_account.dtr_storage.name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

# Get Cloudstor's storage account name and key
data "azurerm_storage_account" "cloudstor_storage_account" {
  name                = "${azurerm_storage_account.cloudstor_storage.name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

# Pass additional options
data "template_file" "extra_opts" {
  template = <<EOF
azure_dtr_storage_account=$${dtr_storage_account}
azure_dtr_storage_key=$${dtr_storage_key}

docker_ucp_license_path=$${ucp_license_path}
docker_ucp_admin_password=$${ucp_admin_password}

azure_app_id=$${azure_app_id}
azure_app_secret=$${azure_app_secret}
azure_tenant_id=$${azure_tenant_id}
azure_subscription_id=$${azure_subscription_id}

cloudstor_plugin_options="CLOUD_PLATFORM=AZURE AZURE_STORAGE_ACCOUNT_KEY=$${cloudstor_key} AZURE_STORAGE_ACCOUNT=$${cloudstor_account} AZURE_STORAGE_ENDPOINT=$${cloudstor_endpoint}"

EOF

  vars {
    dtr_storage_key       = "${data.azurerm_storage_account.dtr_storage_account.primary_access_key}"
    dtr_storage_account   = "${data.azurerm_storage_account.dtr_storage_account.name}"
    ucp_admin_password    = "${local.ucp_admin_password}"
    ucp_license_path      = "${var.ucp_license_path}"
    azure_app_id          = "${var.client_id}"
    azure_app_secret      = "${var.client_secret}"
    azure_tenant_id       = "${var.tenant_id}"
    azure_subscription_id = "${var.subscription_id}"
    cloudstor_key         = "${data.azurerm_storage_account.cloudstor_storage_account.primary_access_key}"
    cloudstor_account     = "${data.azurerm_storage_account.cloudstor_storage_account.name}"
    cloudstor_endpoint    = "core.windows.net"
  }
}

# All Windows machines have the same password
data "template_file" "windows_worker_passwords" {
  count    = "${var.windows_ucp_worker_count}"
  template = "${local.windows_password}"
}

module "inventory" {
  # Would love to use a variable for the path... but Terrraform doesn't allow
  # https://github.com/hashicorp/terraform/issues/1439
  source = "./modules/ansible"

  inventory_file = "${var.ansible_inventory}"

  linux_user               = "${var.linux_user}"
  windows_user             = "${var.windows_user}"
  windows_worker_passwords = "${data.template_file.windows_worker_passwords.*.rendered}"

  linux_ucp_manager_names = "${azurerm_virtual_machine.linux_ucp_manager.*.name}"
  linux_ucp_manager_ips   = "${azurerm_public_ip.linux_ucp_manager.*.ip_address}"

  linux_dtr_worker_names = "${azurerm_virtual_machine.linux_dtr.*.name}"
  linux_dtr_worker_ips   = "${azurerm_public_ip.linux_dtr.*.ip_address}"

  linux_worker_names = "${azurerm_virtual_machine.linux_ucp_worker.*.name}"
  linux_worker_ips   = "${azurerm_public_ip.linux_ucp_worker.*.ip_address}"

  windows_worker_names = "${azurerm_virtual_machine.windows_ucp_worker.*.name}"
  windows_worker_ips   = "${azurerm_public_ip.windows_ucp_worker.*.ip_address}"

  infra_stack = "azure"
  extra_vars  = "${data.template_file.extra_opts.rendered}"

  docker_ucp_lb = "${var.docker_ucp_lb == "" ? module.ucp_app_lb.fqdn : var.docker_ucp_lb}"
  docker_dtr_lb = "${var.docker_dtr_lb == "" ? module.dtr_app_lb.fqdn : var.docker_dtr_lb}"
}
