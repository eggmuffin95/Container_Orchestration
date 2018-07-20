resource "azurerm_network_security_group" "ee_sg" {
  name                = "ee-ansible-nsg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_network_security_group" "linux_sg" {
  name                = "linux-ansible-nsg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_network_security_group" "windows_sg" {
  name                = "windows-ansible-nsg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

# best to comment RDP access out after initial deployment testing!
resource "azurerm_network_security_rule" "rdpRule" {
  name                        = "rdpRule"
  description                 = "Allow RDP in from all locations"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = "${azurerm_network_security_group.windows_sg.name}"
}

# WinRM HTTP & HTTPS remote access - needed for Ansible
resource "azurerm_network_security_rule" "winrmHTTPRule" {
  name                        = "http_ansible_in_winrm"
  description                 = "Allow HTTP remote protocol in from all locations"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "5985"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = "${azurerm_network_security_group.windows_sg.name}"
}

resource "azurerm_network_security_rule" "winrmHTTPSRule" {
  name                        = "https_ansible_in_winrm"
  description                 = "Allow HTTPS remote protocol in from all locations"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "5986"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = "${azurerm_network_security_group.windows_sg.name}"
}

resource "azurerm_network_security_rule" "linux_ssh" {
  name                        = "linux-ssh"
  description                 = "Allow SSH in from all locations to DockerEE"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = "${azurerm_network_security_group.linux_sg.name}"
}

# UCP + DTR port 22 + 80 + 443 rules
resource "azurerm_network_security_rule" "ee_ssh" {
  name                        = "ee-ssh"
  description                 = "Allow SSH in from all locations to DockerEE"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = "${azurerm_network_security_group.ee_sg.name}"
}

resource "azurerm_network_security_rule" "ee_https" {
  name                        = "ee-https"
  description                 = "Allow HTTPS in from all locations to DockerEE"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = "${azurerm_network_security_group.ee_sg.name}"
}

resource "azurerm_network_security_rule" "ee_http" {
  name                        = "ee-http"
  description                 = "Allow HTTP in from all locations to DockerEE"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = "${azurerm_network_security_group.ee_sg.name}"
}
