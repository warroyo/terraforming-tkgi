
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

data "local_file" "tkgi_cluster_data" {
    filename = "${path.module}/bin/cluster.json"
    depends_on = [
    null_resource.tkgi_cluster_info
  ]
}
