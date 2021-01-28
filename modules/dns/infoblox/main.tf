

provider "infoblox"{
  username = var.infoblox_user
  password = var.infoblox_password
  host = var.infoblox_server
  sslverify = false
}


resource "infoblox_record_host" "host" {
  name              = "${var.infoblox_vmname}.${var.infoblox_dns_zone}"
  configure_for_dns = true

  ipv4addr {
    function = "func:nextavailableip:${var.infoblox_range}"
  }
}