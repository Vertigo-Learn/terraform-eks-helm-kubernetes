provider "helm" {
 kubernetes {
   config_path = "./kubeconfig.yaml"
 }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "default"

  set {
    name  = "controller.replicaCount"
    value = "2"
  }

  set {
    name  = "controller.metrics.enabled"
    value = "false"
  }
}