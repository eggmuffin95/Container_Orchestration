# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = "${azurerm_resource_group.rg.name}"
  }

  byte_length = 8
}

# Create storage account for DTR external storage
resource "azurerm_storage_account" "dtr_storage" {
  name                     = "dtr${random_id.randomId.hex}"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${azurerm_resource_group.rg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags {
    Name        = "${azurerm_resource_group.rg.name}-DTRStorage"
    Environment = "${azurerm_resource_group.rg.name}"
  }
}
