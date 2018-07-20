# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

# create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.deployment}"
  location = "${var.region}"
}

# Configure the TLS version
provider "tls" {
  version = "1.1.0"
}
