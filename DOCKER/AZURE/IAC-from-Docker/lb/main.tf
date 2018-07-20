# create the public IP
resource "azurerm_public_ip" "pub_ip" {
  name                = "${var.lb_fe_ip_name}"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"

  public_ip_address_allocation = "static"
  domain_name_label            = "${format("%s-%s", "${var.dns_prefix}", "${lower(replace(var.rg_name, "/[^a-zA-Z0-9]/", ""))}")}"
}

# create the lb
resource "azurerm_lb" "lb" {
  name                = "${var.lb_name}"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"

  frontend_ip_configuration {
    name                 = "${var.fe_ip_cfg_name}"
    public_ip_address_id = "${azurerm_public_ip.pub_ip.id}"
  }
}

# create the load balancer backend pool
resource "azurerm_lb_backend_address_pool" "pool" {
  name                = "${var.lb_pool_name}"
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
}

resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
  name                = "tcpProbe"
  protocol            = "tcp"
  port                = "${var.probe_port}"
  interval_in_seconds = 5
  number_of_probes    = 2
}
