
output "ip" {
  value = infoblox_record_host.host.ipv4addr[0].address
}


output "hostname" {
  value = infoblox_record_host.host.name
}