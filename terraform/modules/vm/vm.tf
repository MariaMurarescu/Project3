resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_B1s"
  admin_username      = "Maria"
  network_interface_ids = [azurerm_network_interface.test.id,]
  admin_ssh_key {
    username   = "Maria"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1VTigIfJDwdyw5nWZ0Mw7WySiXzxc7HY8Cr2GXbZCWHV50LTD5I7OGxmPClvzp33hQMA3iDA4OfKp2n7TZAaVVD4SdTejASUCJv8ejgY2SMcpitArmFxUUqriY6FQN+e11E3i0evYu7B03NK/D1UXGCcQ83NsvtXWrjYJj0j8pDBhWw/US3ly9flnzxkJJLpAFW4xxn4GkUbwpjElf9WQXhKjvk8lL15BtEh7qDNTfgn2oU5fcPyKkDxb9NyACvfo8daSrmh8Zcijuv2LtiVpRd29keDRQEZqCqwamrlpU9ME9OODmDERifh9ApI/dZ15Y9wpEkWmFa3ac1JOrfBFefgmzBZIcUKYBjkGJ1zcmDBbztG5QEtTu9tERQWgSoSi5mCyecZi3r7j84AjDsZX0VsAKRniB5Pxspx/Usa35njCO5vfD+EHEFOFqu7q3rBPIdmRKcb+eD9sZIX/triOvf3foMSEZHk1pF7pjLri/VLIfwFR/tSnesuZMMfalwjKLza+RV0T7JRgWVS/UBw42N/j6UHYyjlg9znzErUJkCI0NKryNpmXkLA2YGbAnDLtArc+ACQLdq5UY6Gzr+Pe8sa6ld8k3IOnrBZxWlJLbcve1MUhT3cEVvwk+m9iTQyCJ+OsWQcGJBcS5dh+RI7FZi32eO3QkBnP88MnADZT1Q== a@DESKTOP-O39HSNC"
    #public_key = file(var.vm_public_key) 
     
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
