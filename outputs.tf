output "bastion_ip" {
    description = "public IP address of the bastion server"
    value = "${module.linuxservers.public_ip_address}"
}

output "bastion_public_name" {
    description = "public Azure dns entry of the bastion server"
    value = "${module.linuxservers.public_ip_dns_name}"
}

output "lb_ip" {
    description = "public IP address of the LB"
    value = "${module.loadbalancer.azurerm_public_ip_address}"
}
