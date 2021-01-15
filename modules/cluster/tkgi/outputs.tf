
output "tkgi_master_ips" {
  value = "${data.external.tkgi_cluster.result["kubernetes_master_ips"]}"
}