variable "infoblox_range" {
  description = "cidr or ip range to lookup next avail ip"
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
