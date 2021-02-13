resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-${var.name}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.prefix}-pub"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  depends_on = ["azurerm_resource_group.main"]

}

resource "azurerm_virtual_network" "vnet2" {
  name                = "${var.prefix}-pri"
  address_space       = ["10.0.1.0/16"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  depends_on = ["azurerm_resource_group.main"]

}

resource "azurerm_subnet" "prisub_vnet1" {
  name                 = "subprivatenet1"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
  address_prefix       = "10.0.2.0/24"
  depends_on = ["azurerm_resource_group.main"]
}

resource "azurerm_subnet" "pubsub_vnet1" {
  name                 = "subpubvatenet1"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
  address_prefix       = "10.0.1.0/24"
  depends_on = ["azurerm_resource_group.main"]
}

resource "azurerm_subnet" "pubsub_vnet2" {
  name                 = "subpubvatenet2"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet2.name}"
  address_prefix       = "10.0.3.0/24"
  depends_on = ["azurerm_resource_group.main"]
}

resource "azurerm_subnet" "prisub_vnet2" {
  name                 = "subprivatenet2"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet2.name}"
  address_prefix       = "10.0.1.0/24"
  depends_on = ["azurerm_resource_group.main"]
} 

resource "azurerm_network_interface" "primary" {
  count               = 1
  name                = "${var.prefix}-nic-${count.index+1}"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  ip_configuration  {
    name              = "public"
    subnet_id         = "${azurerm_subnet.pubsub_vnet1.id}"
    private_ip_address_allocation = "Dynamic"
  }


resource "azurerm_network_interface" "secondary" {
  count               = 1
  name                = "${var.prefix}-nic-${count.index+1}"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  ip_configuration  {
    name              = "public"
    subnet_id         = "${azurerm_subnet.pubsub_vnet2.id}"
    private_ip_address_allocation = "Dynamic"
  }


## ADD Security Groups For Project Fancy
}


