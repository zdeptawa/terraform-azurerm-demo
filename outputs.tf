output "jumpbox_public_ip" {
  description = "public IP address of the jumpbox server"
  value       = "${azurerm_public_ip.jumpbox.ip_address}"
}

output "jumpbox_private_ip" {
  description = "private IP address of the jumpbox server"
  value       = "${azurerm_network_interface.jumpbox.private_ip_address}"
}

output "lb_ip" {
  description = "public IP address of the LB"
  value       = "${module.loadbalancer.azurerm_public_ip_address}"
}

output "postgresql_fqdn" {
  value = "${azurerm_postgresql_server.test.fqdn}"
}
