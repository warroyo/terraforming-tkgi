
resource "kubernetes_secret" "citrix_ns_secret" {
  metadata {
    name = "citrix-ns-secret"
    namespace = "kube-system"
  }

  data = {
    username = var.citrix_ns_user
    password = var.citrix_ns_password
  }

}

data "template_file" "ingress_config" {
  template = file("${path.module}/templates/ingress/values.yml")

  vars = {
    citrix_ns_ip = var.citrix_ns_ip
    citrix_ns_port = var.citrix_ns_port
    citrix_ns_proto = var.citrix_ns_proto
    citrix_ns_secret = kubernetes_secret.citrix_ns_secret.metadata[0].name
  }
}

data "template_file" "ipam_config" {
  template = file("${path.module}/templates/ipam/values.yml")

  vars = {
    vip_range  = jsonencode(var.citrix_vip_range)
  }
}




resource "helm_release" "citrix-ingress" {

  name       = "citrix-ingress"
  namespace  = "kube-system"
  repository = "https://citrix.github.io/citrix-helm-charts"
  chart      = "citrix-ingress-controller"
  version    = "1.12.2"

  values = [data.template_file.ingress_config.rendered]

  timeout    = 400
  depends_on = [ kubernetes_secret.citrix_ns_secret ]
}

resource "helm_release" "citrix-ipam" {

  name       = "citrix-ipam"
  namespace  = "kube-system"
  repository = "https://citrix.github.io/citrix-helm-charts"
  chart      = "citrix-ipam-controller"
  version    = "0.0.1"

  values = [data.template_file.ipam_config.rendered]

  timeout    = 400
}