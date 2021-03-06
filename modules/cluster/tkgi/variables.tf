variable "tkgi_api_url" {
  description = "url to reach the TKGI api"
}

variable "tkgi_skip_ssl_validation" {
  description = "whether or not to skip ssl validation"
  default = "false"
}

variable "tkgi_password" {
  description = "password"
  default = ""
}
variable "tkgi_user" {
  description = "username"
  default = ""
}
variable "tkgi_cluster_name" {
  description = "name for the cluster"
  default = ""
}
variable "tkgi_plan" {
  description = "plan to use when creating the cluster"
  default = ""
}
variable "tkgi_worker_count" {
  description = "number of workers to override plan"
  default = "3"
}
variable "tkgi_external_hostname" {
  description = "hostname for the cluster"
  default = ""
}

variable "tkgi_tags" {
  description = "tags to be added to the vms"
  default = ""
}