module "citrix_vip" {
  source = "../../modules/loadbalancer/citrix"

    tkgi_cp_vip_ip = var.tkgi_cp_vip_ip
    ns_insecure_skip_verify = true
    tkgi_environment_name = "testing"
    tkgi_cp_ips = var.tkgi_cp_ips
    tkgi_cluster_name = "example"
    ns_user = var.ns_user
    ns_password = var.ns_password
    ns_url = var.ns_url
}

variable "tkgi_cp_vip_ip" {
  description = "the ip for the control plane vip"
}



variable "tkgi_cp_ips" {
  description = "The list of control plane node ips"
}

variable "ns_insecure_skip_verify" {
  description = "whether or not to skip ssl verification"
  default = false
}

variable "ns_user" {
  description = "user to login to the netscaler with"
}

variable "ns_password" {
  description = "pasword for the user"
}

variable "ns_url" {
  description = "url of the netscaler"
}