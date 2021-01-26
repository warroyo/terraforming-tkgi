module "citrix_ingress" {
  source = "../../../modules/k8s/citrix"
  citrix_ns_ip = var.citrix_ns_ip
  citrix_ns_password =  var.citrix_ns_password
  citrix_ns_port = var.citrix_ns_port
  citrix_ns_user = var.citrix_ns_user
  citrix_vip_range = var.citrix_vip_range
}

variable "citrix_ns_ip" {
  description = "ip to for the citrix adc server"
}

variable "citrix_ns_password" {
  description = "password"
}

variable "citrix_ns_port" {
  description = "port for the citrix adc server"
  default = "443"
}

variable "citrix_ns_user" {
  description = "user to login with"
}

variable "citrix_vip_range" {
  description = "the range of ips to use for service type loadbalancer"
}
