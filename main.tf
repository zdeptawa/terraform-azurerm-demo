provider "azurerm" {
  version = "~> 0.3"
}

module "network" "demo-network" {
    source              = "Azure/network/azurerm"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    subnet_prefixes     = "${var.subnet_prefixes}"
    subnet_names        = "${var.subnet_names}"
    vnet_name           = "tfaz-vnet"
    sg_name             = "${var.sg_name}"
}

module "loadbalancer" "demo-lb" {
  #source                = "Azure/loadbalancer/azurerm"
  source                = "github.com/Azure/terraform-azurerm-loadbalancer"
  resource_group_name   = "${var.resource_group_name}"
  location              = "${var.location}"
  prefix                = "tfaz"
  lb_port               = { http = ["80", "Tcp", "80"] }
  frontend_name         = "tfaz-public-ip"
}

module "computegroup" "demo-web" {
    source              = "Azure/computegroup/azurerm"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    vmscaleset_name     = "tfaz-vmss"
    vm_size             = "Standard_A0"
    nb_instance         = 3
    vm_os_simple        = "UbuntuServer"
    vnet_subnet_id      = "${module.network.vnet_subnets[0]}"
    load_balancer_backend_address_pool_ids = "${module.loadbalancer.azurerm_lb_backend_address_pool_id}"
    lb_port             = { http = ["80", "Tcp", "80"] }

    admin_username      = "tfaz"
    admin_password      = "BestPasswordEver"
    ssh_key             = "~/.ssh/tfaz_id_rsa.pub"

    cmd_extension       = "sudo apt-get -y install nginx"
}

module "linuxservers" "bastion" {
    #source = "Azure/compute/azurerm"
    source         = "github.com/Azure/terraform-azurerm-compute"
    resource_group_name = "${var.resource_group_name}"
    location       = "${var.location}"
    vm_hostname    = "tfaz-bastion"
    nb_public_ip   = "1"
    nb_instances   = "1"
    vnet_subnet_id = "${module.network.vnet_subnets[0]}"
    vm_os_simple   = "UbuntuServer"
    public_ip_dns  = [ "tfaz-bastion" ]
    admin_username = "tfaz"
    admin_password = "BestPasswordEver"
    ssh_key        = "~/.ssh/tfaz_id_rsa.pub"
}

resource "azurerm_network_security_rule" "allowInternet80" {
    name                   = "allow-internet-port-80"
    direction              = "Inbound"
    access                 = "Allow"
    priority               = 200
    source_address_prefix  = "*"
    source_port_range      = "*"
    destination_address_prefix = "*"
    destination_port_range = "80"
    protocol               = "Tcp"
    resource_group_name    = "${var.resource_group_name}"
    network_security_group_name = "${var.sg_name}"
    depends_on = ["module.network"]
}

resource "azurerm_network_security_rule" "allow22bastion" {
    name                   = "allow-22-bastion"
    direction              = "Inbound"
    access                 = "Allow"
    priority               = 300
    source_address_prefix  = "*"
    source_port_range      = "*"
    destination_address_prefix = "${module.linuxservers.public_ip_address[0]}"
    destination_port_range = "22"
    protocol               = "Tcp"
    resource_group_name    = "${var.resource_group_name}"
    network_security_group_name = "${var.sg_name}"
    depends_on = ["module.network","module.linuxservers"]
}
