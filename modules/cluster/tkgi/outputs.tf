
output "tkgi_master_ips" {
  value = jsondecode(data.local_file.tkgi_cluster_data.content).kubernetes_master_ips
}