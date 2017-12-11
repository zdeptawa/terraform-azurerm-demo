variable "location" {
  default = "southcentralus"
}

variable "resource_group_name" {
  default = "tfms-rg"
}

variable "sg_name" {
  default = "tfms-nsg"  
}

# This is the default variable set in the network module. I left this commented
# as an example - no override needed being the default is the value we wanted!
#variable "address_space" {
#  description = "The address space that is used by the virtual network."
#  default     = "10.0.0.0/16"
#}

variable "subnet_prefixes" {
  default     = [ "10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet_names" {
  default     = [ "tfms-public-subnet", "tfms-private-subnet" ]
}
