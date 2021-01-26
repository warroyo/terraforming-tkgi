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

variable "citrix_ns_proto" {
  description = "protocol to use"
  default = "https"
}

variable "citrix_ns_user" {
  description = "user to login with"
}

variable "citrix_vip_range" {
  description = "the range of ips to use for service type loadbalancer"
}


variable "kubeconfig_path" {
  description = "The path to your .kube/config"
  default = "~/.kube/config"
}