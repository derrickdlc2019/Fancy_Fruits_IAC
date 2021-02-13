provider "azurerm" {
  features {}
}
variable "name" { default = "New_Fancy_Fruits"}
variable "location" {default = "centralus"}
variable "prefix" { default = "devenv"}

#variable "imageSize" { 
#  type = "map"
#  default = { 
#    "test" = "Standard_B"
#   "development " = "Standard_BS2"
#    "production" = "Standard_DS2"
#  
#}

