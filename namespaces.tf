resource "kubernetes_namespace" "example" {
  metadata {
    name = "example-namespace"
  }

  depends_on = [
    local_file.kubeconfig,
    aws_eks_node_group.example
  ]
}