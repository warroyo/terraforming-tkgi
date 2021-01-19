
#this is used to get around the issue with destroy provisioners not having access to 
# vars. this sets up a file that can be sources in all the below scripts.
resource "local_file" "environment_sh" {
    sensitive_content = <<EOF
export TKGI_API_URL="${var.tkgi_api_url}"
export TKGI_SKIP_SSL_VALIDATION="${var.tkgi_skip_ssl_validation}"
export TKGI_PASSWORD="${var.tkgi_password}"
export TKGI_USER="${var.tkgi_user}"
export TKGI_CLUSTER_NAME="${var.tkgi_cluster_name}"
export TKGI_PLAN="${var.tkgi_plan}"
export TKGI_WORKER_COUNT="${var.tkgi_worker_count}"
export TKGI_EXTERNAL_HOSTNAME="${var.tkgi_external_hostname}"
export TKGI_TAGS="${var.tkgi_tags}" 
EOF
    filename = "${path.module}/bin/environment.sh"
}

#we can login in it's own resource since this  cerates a local dotfile with the login info
resource "null_resource" "tkgi_login" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "source bin/environment.sh && bin/tkgi-login.sh"
    working_dir = path.module
  }
  depends_on = [
    local_file.environment_sh
  ]
}


#the below two resources are split due to how null_resource works. in order to allow for 
#updates without a destroy first we need to separate the destroy into it's own rersource.
resource "null_resource" "tkgi_cluster" {
  triggers = {
        tags = var.tkgi_tags
        workers = var.tkgi_worker_count
  }
  provisioner "local-exec" {
    command = "source bin/environment.sh && bin/tkgi-apply.sh"
    working_dir = path.module
  }
  depends_on = [
    null_resource.tkgi_login,
    local_file.environment_sh
  ]
}

resource "null_resource" "tkgi_cluster_destroy" {
  provisioner "local-exec" {
    when = destroy
    command = "source bin/environment.sh && bin/tkgi-delete.sh"
    working_dir = path.module
  }
  depends_on = [
    null_resource.tkgi_login,
    local_file.environment_sh
  ]
}


#this creates a json file from the cluster info to be used in an output
resource "null_resource" "tkgi_cluster_info" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "source bin/environment.sh && bin/tkgi-get.sh"
    working_dir = path.module
  }
  provisioner "local-exec" {
    when = destroy
    command = "rm bin/cluster.json"
    working_dir = path.module
  }

  depends_on = [
    null_resource.tkgi_login,
    null_resource.tkgi_cluster,
    local_file.environment_sh
  ]
}

#create data to be used in the outputs from the previosuly created file
data "local_file" "tkgi_cluster_data" {
    filename = "${path.module}/bin/cluster.json"
    depends_on = [
    null_resource.tkgi_cluster_info
  ]
}
