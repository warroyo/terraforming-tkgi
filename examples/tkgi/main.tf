module "tkgi_cluster" {
  source = "../../modules/cluster/tkgi"

    tkgi_api_url = var.tkgi_api_url
    tkgi_skip_ssl_validation = true
    tkgi_password = var.tkgi_password
    tkgi_user = var.tkgi_user
    tkgi_cluster_name = "example"
    tkgi_plan = "small"
    tkgi_worker_count = var.tkgi_worker_count
    tkgi_external_hostname = var.tkgi_external_hostname
    tkgi_tags = "test:testvalue,hello:example"
}

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