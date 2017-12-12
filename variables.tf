variable "location" {
  default = "southcentralus"
}

variable "resource_group_name" {
  default = "tfaz-rg"
}

variable "sg_name" {
  default = "tfaz-nsg"
}

# This is the default variable set in the network module. I left this commented
# as an example - no override needed being the default is the value we wanted!
#variable "address_space" {
#  description = "The address space that is used by the virtual network."
#  default     = "10.0.0.0/16"
#}

variable "subnet_prefixes" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet_names" {
  default = ["tfaz-public-subnet", "tfaz-private-subnet"]
}

variable "client_id" {
  description = "client_id from your Azure login settings, this can be set using an environment variable by prefixing the env var with TF_VAR_client_id"
}

variable "client_secret" {
  description = "client_secret from your Azure login settings, this can be set using an environment variable by prefixing the env var with TF_VAR_client_secret"
}

variable "subscription_id" {
  description = "subscription_id from your Azure login settings, this can be set using an environment variable by prefixing the env var with TF_VAR_subscription_id"
}

variable "tenant_id" {
  description = "tenant_id from your Azure login settings, this can be set using an environment variable by prefixing the env var with TF_VAR_tenant_id"
}

variable "db_user" {
  default = "psqladminun"
}

variable "db_pass" {
  default = "HaSh1CoR3"
}

variable "ssh_key_public" {}

variable "ssh_key_private" {}
