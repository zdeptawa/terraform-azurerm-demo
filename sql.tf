resource "azurerm_postgresql_server" "test" {
  name                = "postgresql-server-${var.resource_group_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.default.name}"

  sku {
    name     = "PGSQLB50"
    capacity = 50
    tier     = "Basic"
  }

  administrator_login          = "${var.db_user}"
  administrator_login_password = "${var.db_pass}"
  version                      = "9.5"
  storage_mb                   = "51200"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_postgresql_database" "test" {
  name                = "gopher_search_production"
  resource_group_name = "${azurerm_resource_group.default.name}"
  server_name         = "${azurerm_postgresql_server.test.name}"
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

/*
resource "null_resource" "db" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    cluster_instance_ids = "${join(",", azurerm_postgresql_database.test.*.id)}"
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host        = "${azurerm_public_ip.jumpbox.fqdn}"
    user        = "azureuser"
    private_key = "${file("~/.ssh/server_rsa")}"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the clutser
    inline = [
      "wget https://github.com/nicholasjackson/gopher_search/releases/download/v0.1/configure_db.sh",
      "chmod +x ./configure_db.sh",
      "./configure_db.sh ${azurerm_postgresql_server.test.fqdn} ${var.db_user} ${var.db_pass}",
    ]
  }
}
*/

