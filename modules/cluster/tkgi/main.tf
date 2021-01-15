resource "null_resource" "tkg_workload_cluster" {
#   triggers = {
#   }
  provisioner "local-exec" {
    environment = {
      TKGI_API_URL = var.tkgi_api_url
      TKGI_SKIP_SSL_VALIDATION = var.tkgi_skip_ssl_validation
      PKS_USER_PASSWORD = var.tkgi_password
      TKGI_USER = var.tkgi_user
      TKGI_CLUSTER_NAME = var.tkgi_cluster_name
      TKGI_PLAN = var.tkgi_plan
      TKGI_WORKER_COUNT = var.tkgi_worker_count
      TKGI_EXTERNAL_HOSTNAME = var.tkgi_external_hostname
      TKGI_TAGS = var.tkgi_tags
    }
    command = "/bin/tkgi-apply.sh"
    working_dir = "${path.module}"
  }
  provisioner "local-exec" {
    when = destroy
     environment = {
      TKGI_API_URL = var.tkgi_api_url
      TKGI_SKIP_SSL_VALIDATION = var.tkgi_skip_ssl_validation
      PKS_USER_PASWORD = var.tkgi_password
      TKGI_USER = var.tkgi_user
      TKGI_CLUSTER_NAME = var.tkgi_cluster_name
    }
    command = "/bin/tkgi-delete.sh"
    working_dir = "${path.module}"
  }
}

data "external" "tkgi_cluster" {
   depends_on = [
    null_resource.tkg_workload_cluster
  ]
  program = ["sh", "./tkgi-get.sh"]
  working_dir = "${path.module}/bin"
}