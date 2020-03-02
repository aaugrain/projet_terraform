terraform {
  backend "azurerm" {
    resource_group_name  = "6lv1"
    storage_account_name = "storagedesespoir"
    container_name       = "richard3"
    key                  = "kiki.tfstate"
    subscription_id = "092ad35b-0094-4eed-884b-a06a335fbb3a"
    client_id = "9c19e318-731f-4305-a5c7-d6307a8f4ff2"
    client_secret = "49778169-bc89-4a5c-9fbc-44ecf67a3b1e"
    tenant_id = "7a34e3a4-1808-4c92-946a-b78e8f9bdfd5"
  }
}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  tenant_id = "${var.tenant_id}"
  version = "1.44.0"
}
