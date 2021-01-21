
#the below two resources are split due to how null_resource works. in order to allow for 
#updates without a destroy first we need to separate the destroy into it's own rersource.
resource "null_resource" "tkgi_cluster" {
  triggers = {
        tags = var.tkgi_tags
        workers = var.tkgi_worker_count
  }
  provisioner "local-exec" {
    environment = {
      TKGI_API_URL =  var.tkgi_api_url 
      TKGI_SKIP_SSL_VALIDATION = var.tkgi_skip_ssl_validation
      TKGI_PASSWORD = var.tkgi_password
      TKGI_USER = var.tkgi_user
      TKGI_CLUSTER_NAME = var.tkgi_cluster_name
      TKGI_PLAN = var.tkgi_plan
      TKGI_WORKER_COUNT = var.tkgi_worker_count
      TKGI_EXTERNAL_HOSTNAME = var.tkgi_external_hostname
      TKGI_TAGS = var.tkgi_tags
    }
    command = "bin/tkgi-login.sh && bin/tkgi-apply.sh"
    working_dir = path.module
  }
  depends_on = [
  ]
}

resource "null_resource" "tkgi_cluster_destroy" {
  triggers = {
      tkgi_api_url =  var.tkgi_api_url 
      tkgi_skip_ssl_validation = var.tkgi_skip_ssl_validation
      tkgi_password = var.tkgi_password
      tkgi_user = var.tkgi_user
      tkgi_cluster_name = var.tkgi_cluster_name
  }
  provisioner "local-exec" {
     environment = {
      TKGI_API_URL =  self.triggers.tkgi_api_url 
      TKGI_SKIP_SSL_VALIDATION =  self.triggers.tkgi_skip_ssl_validation
      TKGI_PASSWORD =  self.triggers.tkgi_password
      TKGI_USER =  self.triggers.tkgi_user
      TKGI_CLUSTER_NAME =  self.triggers.tkgi_cluster_name
    }
    when = destroy
    command = "bin/tkgi-login.sh && bin/tkgi-delete.sh"
    working_dir = path.module
  }
  depends_on = [
  ]
}


#this creates a json file from the cluster info to be used in an output
resource "null_resource" "tkgi_cluster_info" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
     environment = {
      TKGI_API_URL =  var.tkgi_api_url 
      TKGI_SKIP_SSL_VALIDATION = var.tkgi_skip_ssl_validation
      TKGI_PASSWORD = var.tkgi_password
      TKGI_USER = var.tkgi_user
      TKGI_CLUSTER_NAME = var.tkgi_cluster_name
    }
    command = "bin/tkgi-login.sh && bin/tkgi-get.sh"
    working_dir = path.module
  }
  provisioner "local-exec" {
    when = destroy
    command = "rm bin/cluster.json"
    working_dir = path.module
  }

  depends_on = [
    null_resource.tkgi_cluster,
  ]
}

#create data to be used in the outputs from the previosuly created file
data "local_file" "tkgi_cluster_data" {
    filename = "${path.module}/bin/cluster.json"
    depends_on = [
    null_resource.tkgi_cluster_info
  ]
}
