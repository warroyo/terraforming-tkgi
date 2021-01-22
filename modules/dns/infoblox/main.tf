
provider "infoblox"{
  username = var.infoblox_user
  password = var.infoblox_password
  server = var.infoblox_server
}

resource "infoblox_ip_allocation" "get_ip"{
  vm_name = var.infoblox_vmname
  cidr = var.infoblox_cidr
  tenant_id = var.infoblox_tenant_id
}

resource "infoblox_a_record" "add_dns"{
  ip_addr = infoblox_ip_allocation.get_ip.ip_addr
  vm_name = var.infoblox_vmname
  zone= var.infoblox_dns_zone
  tenant_id = var.infoblox_tenant_id
  cidr = var.infoblox_cidr
}