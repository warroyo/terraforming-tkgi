module "infoblox_ip" {
  source = "../../modules/dns/infoblox"

    infoblox_range = var.infoblox_range
    infoblox_dns_zone = var.infoblox_dns_zone
    infoblox_password = var.infoblox_password
    infoblox_server = var.infoblox_server
    infoblox_user = var.infoblox_user
    infoblox_vmname = var.infoblox_vmname
}

variable "infoblox_range" {
  description = "cidr or ip range to use when allocating ip"
}

variable "infoblox_dns_zone" {
  description = "dns zone"
}

variable "infoblox_password" {
  description = "password"
}

variable "infoblox_server" {
  description = "hostname or ip of infoblox"
}

variable "infoblox_user" {
  description = "user to login with"
}

variable "infoblox_vmname" {
  description = "the name to use for the dns hostname and ip allocation"
}


output "ip" {
  value = module.infoblox_ip.ip
}

output "hostname" {
  value = module.infoblox_ip.hostname
}