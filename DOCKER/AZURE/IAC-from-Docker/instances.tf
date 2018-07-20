# ---------------------------------------------------------------------------------------------------------------------
# CREATE ALL INSTANCES FOR MANAGERS, DTR AND WORKERS
# ---------------------------------------------------------------------------------------------------------------------

# Create a common availability set for all machines
resource "azurerm_availability_set" "ucp_managers" {
  name                = "ucp-managers"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  managed             = true
}

# UCP Manager Instances:
resource "azurerm_virtual_machine" "linux_ucp_manager" {
  count = "${var.linux_ucp_manager_count}"

  name                  = "${format("%s-Manager-Linux-%s", azurerm_resource_group.rg.name, "${count.index + 1}")}"
  location              = "${azurerm_resource_group.rg.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  vm_size               = "${var.linux_manager_instance_type}"
  network_interface_ids = ["${element(azurerm_network_interface.linux_ucp_manager.*.id, count.index)}"]
  availability_set_id   = "${azurerm_availability_set.ucp_managers.id}"

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true

  storage_image_reference {
    publisher = "${var.linux_manager["publisher"]}"
    offer     = "${var.linux_manager["offer"]}"
    sku       = "${var.linux_manager["sku"]}"
    version   = "${var.linux_manager["version"]}"
  }

  storage_os_disk {
    name              = "${format("Manager-LinuxOSDisk-%s", "${count.index + 1}")}"
    create_option     = "FromImage"
    caching           = "${var.linux_manager_os_disk_cache}"
    managed_disk_type = "${var.linux_manager_os_disk_type}"
  }

  os_profile {
    computer_name  = "${format("Mgr-Linux-%s", "${count.index + 1}")}"
    admin_username = "${var.linux_user}"
    admin_password = ""
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.linux_user}/.ssh/authorized_keys"
      key_data = "${local.ssh_pub_key}"
    }
  }

  tags {
    name = "${format("%s-Manager-Linux-%s", azurerm_resource_group.rg.name, "${count.index + 1}")}"
  }
}

# UCP Worker Instances:
resource "azurerm_availability_set" "ucp_workers" {
  name                = "ucp-workers"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  managed             = true
}

resource "azurerm_virtual_machine" "linux_ucp_worker" {
  count = "${var.linux_ucp_worker_count}"

  name                  = "${format("%s-Worker-Linux-%s", azurerm_resource_group.rg.name, "${count.index + 1}")}"
  location              = "${azurerm_resource_group.rg.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  vm_size               = "${var.linux_worker_instance_type}"
  network_interface_ids = ["${element(azurerm_network_interface.linux_ucp_worker.*.id, count.index)}"]
  availability_set_id   = "${azurerm_availability_set.ucp_workers.id}"

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true

  storage_image_reference {
    publisher = "${var.linux_worker["publisher"]}"
    offer     = "${var.linux_worker["offer"]}"
    sku       = "${var.linux_worker["sku"]}"
    version   = "${var.linux_worker["version"]}"
  }

  storage_os_disk {
    name              = "${format("Worker-LinuxOSDisk-%s", "${count.index + 1}")}"
    create_option     = "FromImage"
    caching           = "${var.linux_worker_os_disk_cache}"
    managed_disk_type = "${var.linux_worker_os_disk_type}"
  }

  os_profile {
    computer_name  = "${format("Wrkr-Linux-%s", "${count.index + 1}")}"
    admin_username = "${var.linux_user}"
    admin_password = ""
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.linux_user}/.ssh/authorized_keys"
      key_data = "${local.ssh_pub_key}"
    }
  }

  tags {
    name = "${format("%s-Worker-Linux-%s", azurerm_resource_group.rg.name, "${count.index + 1}")}"
  }
}

# Windows Workers:
resource "azurerm_availability_set" "ucp_windows" {
  name                = "ucp-windows"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  managed             = true
}

resource "azurerm_virtual_machine" "windows_ucp_worker" {
  count = "${var.windows_ucp_worker_count}"

  name                  = "${format("%s-Worker-Windows-%s", azurerm_resource_group.rg.name, "${count.index + 1}")}"
  location              = "${azurerm_resource_group.rg.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  vm_size               = "${var.windows_worker_instance_type}"
  network_interface_ids = ["${element(azurerm_network_interface.windows_ucp_worker.*.id, count.index)}"]
  availability_set_id   = "${azurerm_availability_set.ucp_windows.id}"

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true

  storage_image_reference {
    publisher = "${var.windows_worker["publisher"]}"
    offer     = "${var.windows_worker["offer"]}"
    sku       = "${var.windows_worker["sku"]}"
    version   = "${var.windows_worker["version"]}"
  }

  storage_os_disk {
    name              = "${format("Worker-WindowsOSDisk-%s", "${count.index + 1}")}"
    create_option     = "FromImage"
    caching           = "${var.windows_worker_os_disk_cache}"
    managed_disk_type = "${var.windows_worker_os_disk_type}"
  }

  os_profile {
    computer_name  = "${format("Wrkr-Windows-%s", "${count.index + 1}")}"
    admin_username = "${var.windows_user}"
    admin_password = "${local.windows_password}"

    custom_data = <<EOF
<powershell>
  # Set Administrator password
  ([adsi]("WinNT://./administrator, user")).SetPassword("${local.windows_password}")
</powershell>
EOF
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }

  tags {
    name = "${format("%s-Worker-Windows-%s", azurerm_resource_group.rg.name, "${count.index + 1}")}"
  }
}

resource "azurerm_virtual_machine_extension" "windows_ucp_worker_startup" {
  count                = "${var.windows_ucp_worker_count}"
  name                 = "${format("windows-loader-%s", "${count.index+1}")}"
  location             = "${azurerm_resource_group.rg.location}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_machine_name = "${element(azurerm_virtual_machine.windows_ucp_worker.*.name, count.index)}"
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.8"

  settings = <<SETTINGS
  {
      "fileUris": [
        "https://download.docker.com/winrm/scripts/ConfigureRemotingForAnsible.ps1"
      ],
      "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File ConfigureRemotingForAnsible.ps1"
  }
SETTINGS
}

# DTR Instances:
resource "azurerm_availability_set" "ucp_dtrs" {
  name                = "ucp-dtrs"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  managed             = true
}

resource "azurerm_virtual_machine" "linux_dtr" {
  count = "${var.linux_dtr_count}"

  name                  = "${format("%s-DTR-Linux-%s", azurerm_resource_group.rg.name, "${count.index + 1}")}"
  location              = "${azurerm_resource_group.rg.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  vm_size               = "${var.dtr_instance_type}"
  network_interface_ids = ["${element(azurerm_network_interface.linux_dtr.*.id, count.index)}"]
  availability_set_id   = "${azurerm_availability_set.ucp_dtrs.id}"

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true

  storage_image_reference {
    publisher = "${var.linux_manager["publisher"]}"
    offer     = "${var.linux_manager["offer"]}"
    sku       = "${var.linux_manager["sku"]}"
    version   = "${var.linux_manager["version"]}"
  }

  storage_os_disk {
    name              = "${format("DTR-LinuxOSDisk-%s", "${count.index + 1}")}"
    create_option     = "FromImage"
    caching           = "${var.linux_manager_os_disk_cache}"
    managed_disk_type = "${var.linux_manager_os_disk_type}"
  }

  os_profile {
    computer_name  = "${format("DTR-Linux-%s", "${count.index + 1}")}"
    admin_username = "${var.linux_user}"
    admin_password = ""
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.linux_user}/.ssh/authorized_keys"
      key_data = "${local.ssh_pub_key}"
    }
  }

  tags {
    name = "${format("%s-DTR-Linux-%s", azurerm_resource_group.rg.name, "${count.index + 1}")}"
  }
}
