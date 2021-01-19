terraform {
  required_providers {
    citrixadc = {
      source = "terraform.example.com/citrix/citrixadc"
    }
  }
}

provider "citrixadc" {
    insecure_skip_verify = var.ns_insecure_skip_verify
    username = var.ns_user
    password = var.ns_password
    endpoint = var.ns_url
}


resource "citrixadc_lbvserver" "cp_lb" {
  name = "${var.tkgi_environment_name}-${var.tkgi_cluster_name}-cp-lb"
  ipv46 = var.tkgi_cp_vip_ip
  port = "8443"
  servicetype = "TCP"
  lbmethod = "ROUNDROBIN"
}


resource "citrixadc_servicegroup" "cp_sg" {
  servicegroupname = "${var.tkgi_environment_name}-${var.tkgi_cluster_name}-cp-sg"
  lbvservers       = [citrixadc_lbvserver.cp_lb.name]
  servicetype      = "TCP"
  clttimeout       = 40
  servicegroupmembers = formatlist(
    "%s:%s:%s",
    var.tkgi_cp_ips,
    "8443",
    "1"
  )
}

resource "null_resource" "commit_ns" {
  
  triggers = {
     members = jsonencode(var.tkgi_cp_ips)
     vip = var.tkgi_cp_vip_ip
  }
  
  provisioner "local-exec" {
    environment = {
      NS_USER = var.ns_user
      NS_PASSWORD = var.ns_password
      NS_URL = var.ns_url
    }
    command = "bin/ns_commit.sh"
    working_dir = path.module
  }
  depends_on = [
    citrixadc_servicegroup.cp_sg
  ]
}