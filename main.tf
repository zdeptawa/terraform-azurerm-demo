provider "azurerm" {
  version = "~> 0.3"
}

module "network" "demo-network" {
    source              = "Azure/network/azurerm"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    subnet_prefixes     = "${var.subnet_prefixes}"
    subnet_names        = "${var.subnet_names}"
    vnet_name           = "tfms-vnet"
    sg_name             = "${var.sg_name}"
}

module "loadbalancer" "demo-lb" {
  #source                = "Azure/loadbalancer/azurerm"
  source = "github.com/Azure/terraform-azurerm-loadbalancer"
  resource_group_name   = "${var.resource_group_name}"
  location              = "${var.location}"
  prefix                = "tfms"
  lb_port               = { http = ["80", "Tcp", "80"] }
  frontend_name         = "tfms-public-ip"
}

module "computegroup" "demo-web" {
    source              = "Azure/computegroup/azurerm"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    vmscaleset_name     = "tfms-vmss"
    vm_size             = "Standard_A0"
    nb_instance         = 3
    vm_os_simple        = "UbuntuServer"
    vnet_subnet_id      = "${module.network.vnet_subnets[0]}"
    load_balancer_backend_address_pool_ids = "${module.loadbalancer.azurerm_lb_backend_address_pool_id}"
    lb_port             = { http = ["80", "Tcp", "80"] }

    admin_username      = "tfms-user"
    admin_password      = "BestPasswordEver"
    ssh_key             = "~/.ssh/tfms_id_rsa.pub"

    cmd_extension       = "sudo apt-get -y install nginx; hostname > /var/www/html/index.html"
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
}

module "linuxservers" "bastion" {
    #source = "Azure/compute/azurerm"
    source         = "github.com/Azure/terraform-azurerm-compute"
    location       = "${var.location}"
    vm_hostname    = "tfms-bastion"
    nb_public_ip   = "1"
    remote_port    = "22"
    nb_instances   = "1"
    vnet_subnet_id = "${module.network.vnet_subnets[0]}"
    vm_os_simple   = "UbuntuServer"
    public_ip_dns  = [ "tfms-bastion" ]
}
