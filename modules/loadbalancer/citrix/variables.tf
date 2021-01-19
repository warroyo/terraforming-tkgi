variable "tkgi_cp_vip_ip" {
  description = "the ip for the control plane vip"
}

variable "tkgi_environment_name" {
  description = "env name to be used in naming conventions"
}

variable "tkgi_cluster_name" {
  description = "cluster name"
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