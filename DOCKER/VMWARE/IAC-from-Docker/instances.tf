#
# Linux UCP/DTR nodes
#

locals {
  # Common VM/disk name prefixes
  prefix_manager_linux        = "${var.deployment}-mgr"
  prefix_worker_linux         = "${var.deployment}-wrk"
  prefix_linux_dtr            = "${var.deployment}-dtr"
  prefix_worker_windows       = "${var.deployment}-win"
  prefix_linux_database       = "${var.deployment}-ldb"
  prefix_linux_build_server   = "${var.deployment}-lbs"
  prefix_linux_ucp_lb         = "${var.deployment}-ulb"
  prefix_linux_dtr_lb         = "${var.deployment}-dlb"
  prefix_windows_database     = "${var.deployment}-wdb"
  prefix_windows_build_server = "${var.deployment}-wbs"

  # Uninstall commands
  default_command               = "echo No ansible uninstall command defined. See documentation for details. Not uninstalling:"
  linux_ucp_uninstall_command   = "${var.linux_ucp_uninstall_command == "" ? local.default_command : var.linux_ucp_uninstall_command}"
  windows_ucp_uninstall_command = "${var.windows_ucp_uninstall_command == "" ? local.default_command : var.windows_ucp_uninstall_command}"
  linux_dtr_uninstall_command   = "${var.linux_dtr_uninstall_command == "" ? local.default_command : var.linux_dtr_uninstall_command}"
}

# Windows computer names are limited to 15 characters. The following
# null_resource will fail if the hostname is longer than 13 characters, which
# should also give enough room for a two digit counter. Terraform doesn't
# currently have the ability to raise an error directly, see discussion in
# https://github.com/hashicorp/terraform/issues/15469

resource "null_resource" "is_windows_hostname_too_long" {
  count = "${(var.windows_ucp_worker_count > 0 && length(local.prefix_worker_windows) > 13) ||
               (var.windows_database_count > 0 && length(local.prefix_windows_database) > 13) ||
               (var.windows_build_server_count > 0 && length(local.prefix_windows_build_server) > 13) ? 1 : 0}"

  "Error: Windows hostnames could exceed 15 characters with the current prefix (${var.deployment}). Reduce the prefix-length to resolve this error." = true
}

resource "vsphere_virtual_machine" "linux_ucp_manager" {
  count = "${var.linux_ucp_manager_count}"

  name     = "${local.prefix_manager_linux}${count.index+1}"
  num_cpus = "${var.vm_ucp_manager_num_cpus}"
  memory   = "${var.vm_ucp_manager_memory}"

  datastore_id     = "${data.vsphere_datastore.default_datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.default_resource_pool.id}"

  folder = "${var.vsphere_vm_folder}"

  network_interface {
    network_id = "${data.vsphere_network.default_network.id}"

    # Add other network interface properties to clone here, e.g. adapter type
  }

  disk {
    label            = "${local.prefix_manager_linux}${count.index+1}.vmdk"
    size             = "${data.vsphere_virtual_machine.linux_template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.linux_template.disks.0.thin_provisioned}"
    eagerly_scrub    = "${var.vsphere_eagerly_scrub}"

    # Add other disk properties to clone here, e.g. thin_provisioning and eagerly_scrub
  }

  guest_id = "${data.vsphere_virtual_machine.linux_template.guest_id}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.linux_template.id}"

    linked_clone = "${var.vsphere_linked_clone}"

    customize {
      linux_options {
        host_name = "${local.prefix_manager_linux}${count.index+1}"
        domain    = "${var.vsphere_linux_template_domain}"
      }

      network_interface {}

      # Add other customization options here, e.g. network config
    }
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "${local.linux_ucp_uninstall_command} ${self.name}"
  }
}

resource "vsphere_virtual_machine" "linux_ucp_worker" {
  count = "${var.linux_ucp_worker_count}"

  name     = "${local.prefix_worker_linux}${count.index+1}"
  num_cpus = "${var.vm_ucp_worker_num_cpus}"
  memory   = "${var.vm_ucp_worker_memory}"

  datastore_id     = "${data.vsphere_datastore.default_datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.default_resource_pool.id}"

  folder = "${var.vsphere_vm_folder}"

  network_interface {
    network_id = "${data.vsphere_network.default_network.id}"

    # Add other network interface properties to clone here, e.g. adapter type
  }

  disk {
    label            = "${local.prefix_worker_linux}${count.index+1}.vmdk"
    size             = "${data.vsphere_virtual_machine.linux_template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.linux_template.disks.0.thin_provisioned}"
    eagerly_scrub    = "${var.vsphere_eagerly_scrub}"

    # Add other disk properties to clone here, e.g. thin_provisioning and eagerly_scrub
  }

  guest_id = "${data.vsphere_virtual_machine.linux_template.guest_id}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.linux_template.id}"

    linked_clone = "${var.vsphere_linked_clone}"

    customize {
      linux_options {
        host_name = "${local.prefix_worker_linux}${count.index+1}"
        domain    = "${var.vsphere_linux_template_domain}"
      }

      network_interface {}

      # Add other customization options here, e.g. network config
    }
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "${local.linux_ucp_uninstall_command} ${self.name}"
  }
}

resource "vsphere_virtual_machine" "linux_dtr" {
  count = "${var.linux_dtr_count}"

  name     = "${local.prefix_linux_dtr}${count.index+1}"
  num_cpus = "${var.vm_dtr_num_cpus}"
  memory   = "${var.vm_dtr_memory}"

  datastore_id     = "${data.vsphere_datastore.default_datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.default_resource_pool.id}"

  folder = "${var.vsphere_vm_folder}"

  network_interface {
    network_id = "${data.vsphere_network.default_network.id}"

    # Add other network interface properties to clone here, e.g. adapter type
  }

  disk {
    label            = "${local.prefix_linux_dtr}${count.index+1}.vmdk"
    size             = "${data.vsphere_virtual_machine.linux_template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.linux_template.disks.0.thin_provisioned}"
    eagerly_scrub    = "${var.vsphere_eagerly_scrub}"

    # Add other disk properties to clone here, e.g. thin_provisioning and eagerly_scrub
  }

  guest_id = "${data.vsphere_virtual_machine.linux_template.guest_id}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.linux_template.id}"

    linked_clone = "${var.vsphere_linked_clone}"

    customize {
      linux_options {
        host_name = "${local.prefix_linux_dtr}${count.index+1}"
        domain    = "${var.vsphere_linux_template_domain}"
      }

      network_interface {}

      # Add other customization options here, e.g. network config
    }
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "${local.linux_dtr_uninstall_command} ${self.name}"
  }
}

#
# Windows worker nodes
#

resource "vsphere_virtual_machine" "windows_ucp_worker" {
  count = "${var.windows_ucp_worker_count}"

  name     = "${local.prefix_worker_windows}${count.index+1}"
  num_cpus = "${var.vm_ucp_worker_num_cpus}"
  memory   = "${var.vm_ucp_worker_memory}"

  datastore_id     = "${data.vsphere_datastore.default_datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.default_resource_pool.id}"

  folder = "${var.vsphere_vm_folder}"

  network_interface {
    network_id = "${data.vsphere_network.default_network.id}"

    # Add other network interface properties to clone here, e.g. adapter type
  }

  disk {
    label            = "${local.prefix_worker_windows}${count.index+1}.vmdk"
    size             = "${data.vsphere_virtual_machine.windows_template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.windows_template.disks.0.thin_provisioned}"
    eagerly_scrub    = "${var.vsphere_eagerly_scrub}"

    # Add other disk properties to clone here, e.g. thin_provisioning and eagerly_scrub
  }

  guest_id = "${data.vsphere_virtual_machine.windows_template.guest_id}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.windows_template.id}"

    linked_clone = "${var.vsphere_linked_clone}"

    customize {
      windows_options {
        computer_name  = "${local.prefix_worker_windows}${count.index+1}"
        workgroup      = "${var.vsphere_windows_template_workgroup}"
        admin_password = "${local.windows_password}"
      }

      network_interface {}

      # Add other customization options here, e.g. domain info, network config
    }
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "${local.windows_ucp_uninstall_command} ${self.name}"
  }
}

# Database servers

resource "vsphere_virtual_machine" "linux_database" {
  count = "${var.linux_database_count}"

  name     = "${local.prefix_linux_database}${count.index+1}"
  num_cpus = "${var.vm_db_num_cpus}"
  memory   = "${var.vm_db_memory}"

  datastore_id     = "${data.vsphere_datastore.default_datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.default_resource_pool.id}"

  folder = "${var.vsphere_vm_folder}"

  network_interface {
    network_id = "${data.vsphere_network.default_network.id}"

    # Add other network interface properties to clone here, e.g. adapter type
  }

  disk {
    label            = "${local.prefix_linux_database}${count.index+1}.vmdk"
    size             = "${data.vsphere_virtual_machine.linux_template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.linux_template.disks.0.thin_provisioned}"
    unit_number      = 0
    eagerly_scrub    = "${var.vsphere_eagerly_scrub}"

    # Add other disk properties to clone here, e.g. thin_provisioning and eagerly_scrub
  }

  # Additional disk for database servers.
  disk {
    label         = "${local.prefix_linux_database}${count.index+1}-db.vmdk"
    size          = "${var.vm_db_disk_size}"
    unit_number   = 1
    eagerly_scrub = "${var.vsphere_eagerly_scrub}"

    # Add custom disk options here
  }

  guest_id = "${data.vsphere_virtual_machine.linux_database_template.guest_id}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.linux_database_template.id}"

    linked_clone = "${var.vsphere_linked_clone}"

    customize {
      linux_options {
        host_name = "${local.prefix_linux_database}${count.index+1}"
        domain    = "${var.vsphere_linux_template_domain}"
      }

      network_interface {}

      # Add other customization options here, e.g. domain info, network config
    }
  }
}

resource "vsphere_virtual_machine" "windows_database" {
  count = "${var.windows_database_count}"

  name     = "${local.prefix_windows_database}${count.index+1}"
  num_cpus = "${var.vm_db_num_cpus}"
  memory   = "${var.vm_db_memory}"

  datastore_id     = "${data.vsphere_datastore.default_datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.default_resource_pool.id}"

  folder = "${var.vsphere_vm_folder}"

  network_interface {
    network_id = "${data.vsphere_network.default_network.id}"

    # Add other network interface properties to clone here, e.g. adapter type
  }

  disk {
    label            = "${local.prefix_windows_database}${count.index+1}.vmdk"
    size             = "${data.vsphere_virtual_machine.windows_template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.windows_template.disks.0.thin_provisioned}"
    unit_number      = 0
    eagerly_scrub    = "${var.vsphere_eagerly_scrub}"

    # Add other disk properties to clone here, e.g. thin_provisioning and eagerly_scrub
  }

  # Additional disk for database servers.
  disk {
    label         = "${local.prefix_windows_database}${count.index+1}-db.vmdk"
    size          = "${var.vm_db_disk_size}"
    unit_number   = 1
    eagerly_scrub = "${var.vsphere_eagerly_scrub}"

    # Add custom disk options here
  }

  guest_id = "${data.vsphere_virtual_machine.windows_database_template.guest_id}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.windows_database_template.id}"

    linked_clone = "${var.vsphere_linked_clone}"

    customize {
      windows_options {
        computer_name  = "${local.prefix_windows_build_server}${count.index+1}"
        workgroup      = "${var.vsphere_windows_template_workgroup}"
        admin_password = "${local.windows_password}"
      }

      network_interface {}

      # Add other customization options here, e.g. domain info, network config
    }
  }
}

# Build servers

resource "vsphere_virtual_machine" "linux_build_server" {
  count = "${var.linux_build_server_count}"

  name     = "${local.prefix_linux_build_server}${count.index+1}"
  num_cpus = "${var.vm_build_num_cpus}"
  memory   = "${var.vm_build_memory}"

  datastore_id     = "${data.vsphere_datastore.default_datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.default_resource_pool.id}"

  folder = "${var.vsphere_vm_folder}"

  network_interface {
    network_id = "${data.vsphere_network.default_network.id}"

    # Add other network interface properties to clone here, e.g. adapter type
  }

  disk {
    label            = "${local.prefix_linux_build_server}${count.index+1}.vmdk"
    size             = "${data.vsphere_virtual_machine.linux_build_server_template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.linux_build_server_template.disks.0.thin_provisioned}"
    unit_number      = 0
    eagerly_scrub    = "${var.vsphere_eagerly_scrub}"

    # Add other disk properties to clone here, e.g. thin_provisioning and eagerly_scrub
  }

  # Additional disk for database servers.
  disk {
    label         = "${local.prefix_linux_build_server}${count.index+1}-build.vmdk"
    size          = "${var.vm_build_disk_size}"
    unit_number   = 1
    eagerly_scrub = "${var.vsphere_eagerly_scrub}"

    # Add custom disk options here
  }

  guest_id = "${data.vsphere_virtual_machine.linux_build_server_template.guest_id}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.linux_build_server_template.id}"

    linked_clone = "${var.vsphere_linked_clone}"

    customize {
      linux_options {
        host_name = "${local.prefix_linux_build_server}${count.index+1}"
        domain    = "${var.vsphere_linux_template_domain}"
      }

      network_interface {}

      # Add other customization options here, e.g. domain info, network config
    }
  }
}

resource "vsphere_virtual_machine" "windows_build_server" {
  count = "${var.windows_build_server_count}"

  name     = "${local.prefix_windows_build_server}${count.index+1}"
  num_cpus = "${var.vm_build_num_cpus}"
  memory   = "${var.vm_build_memory}"

  datastore_id     = "${data.vsphere_datastore.default_datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.default_resource_pool.id}"

  folder = "${var.vsphere_vm_folder}"

  network_interface {
    network_id = "${data.vsphere_network.default_network.id}"

    # Add other network interface properties to clone here, e.g. adapter type
  }

  disk {
    label            = "${local.prefix_windows_build_server}${count.index+1}.vmdk"
    size             = "${data.vsphere_virtual_machine.windows_build_server_template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.windows_build_server_template.disks.0.thin_provisioned}"
    unit_number      = 0
    eagerly_scrub    = "${var.vsphere_eagerly_scrub}"

    # Add other disk properties to clone here, e.g. thin_provisioning and eagerly_scrub
  }

  # Additional disk for database servers.
  disk {
    label         = "${local.prefix_windows_build_server}${count.index+1}-build.vmdk"
    size          = "${var.vm_build_disk_size}"
    unit_number   = 1
    eagerly_scrub = "${var.vsphere_eagerly_scrub}"

    # Add custom disk options here
  }

  guest_id = "${data.vsphere_virtual_machine.windows_build_server_template.guest_id}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.windows_build_server_template.id}"

    linked_clone = "${var.vsphere_linked_clone}"

    customize {
      windows_options {
        computer_name  = "${local.prefix_windows_build_server}${count.index+1}"
        workgroup      = "${var.vsphere_windows_template_workgroup}"
        admin_password = "${local.windows_password}"
      }

      network_interface {}

      # Add other customization options here, e.g. domain info, network config
    }
  }
}

# Load Balancers

resource "vsphere_virtual_machine" "linux_ucp_lb" {
  count = "1"

  name     = "${local.prefix_linux_ucp_lb}${count.index+1}"
  num_cpus = "${var.vm_lb_num_cpus}"
  memory   = "${var.vm_lb_memory}"

  datastore_id     = "${data.vsphere_datastore.default_datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.default_resource_pool.id}"

  folder = "${var.vsphere_vm_folder}"

  network_interface {
    network_id = "${data.vsphere_network.default_network.id}"

    # Add other network interface properties to clone here, e.g. adapter type
  }

  disk {
    label            = "${local.prefix_linux_ucp_lb}${count.index+1}.vmdk"
    size             = "${data.vsphere_virtual_machine.linux_load_balancer_template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.linux_load_balancer_template.disks.0.thin_provisioned}"
    eagerly_scrub    = "${var.vsphere_eagerly_scrub}"

    # Add other disk properties to clone here, e.g. thin_provisioning and eagerly_scrub
  }

  guest_id = "${data.vsphere_virtual_machine.linux_load_balancer_template.guest_id}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.linux_load_balancer_template.id}"

    linked_clone = "${var.vsphere_linked_clone}"

    customize {
      linux_options {
        host_name = "${local.prefix_linux_ucp_lb}${count.index+1}"
        domain    = "${var.vsphere_linux_template_domain}"
      }

      network_interface {}

      # Add other customization options here, e.g. domain info, network config
    }
  }
}

resource "vsphere_virtual_machine" "linux_dtr_lb" {
  count = "1"

  name     = "${local.prefix_linux_dtr_lb}${count.index+1}"
  num_cpus = "${var.vm_lb_num_cpus}"
  memory   = "${var.vm_lb_memory}"

  datastore_id     = "${data.vsphere_datastore.default_datastore.id}"
  resource_pool_id = "${data.vsphere_resource_pool.default_resource_pool.id}"

  folder = "${var.vsphere_vm_folder}"

  network_interface {
    network_id = "${data.vsphere_network.default_network.id}"

    # Add other network interface properties to clone here, e.g. adapter type
  }

  disk {
    label            = "${local.prefix_linux_dtr_lb}${count.index+1}.vmdk"
    size             = "${data.vsphere_virtual_machine.linux_load_balancer_template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.linux_load_balancer_template.disks.0.thin_provisioned}"
    eagerly_scrub    = "${var.vsphere_eagerly_scrub}"

    # Add other disk properties to clone here, e.g. thin_provisioning and eagerly_scrub
  }

  guest_id = "${data.vsphere_virtual_machine.linux_load_balancer_template.guest_id}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.linux_load_balancer_template.id}"

    linked_clone = "${var.vsphere_linked_clone}"

    customize {
      linux_options {
        host_name = "${local.prefix_linux_dtr_lb}${count.index+1}"
        domain    = "${var.vsphere_linux_template_domain}"
      }

      network_interface {}

      # Add other customization options here, e.g. domain info, network config
    }
  }
}
