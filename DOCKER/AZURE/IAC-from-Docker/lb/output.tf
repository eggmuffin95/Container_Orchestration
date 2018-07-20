output "pool_id" {
  value = "${azurerm_lb_backend_address_pool.pool.id}"
}

output "probe_id" {
  value = "${azurerm_lb_probe.lb_probe.id}"
}

output "lb_id" {
  value = "${azurerm_lb.lb.id}"
}

output "fqdn" {
  value = "${azurerm_public_ip.pub_ip.fqdn}"
}
