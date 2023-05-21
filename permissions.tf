resource "kubernetes_role" "example" {
  metadata {
    name      = "example-role"
    namespace = "example-namespace"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list"]
  }

  depends_on = [
    kubernetes_namespace.example
  ]
}

resource "kubernetes_role_binding" "example" {
  metadata {
    name      = "example-role-binding"
    namespace = "example-namespace"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.example.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "example-user"
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [
    kubernetes_role.example
  ]
}

output "kubeconfig" {
  description = "Kubeconfig for the example user"
  value       = <<EOF
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority-data: ${aws_eks_cluster.example.certificate_authority.0.data}
    server: ${aws_eks_cluster.example.endpoint}
  name: ${aws_eks_cluster.example.name}
contexts:
- context:
    cluster: ${aws_eks_cluster.example.name}
    user: example-user
    namespace: example-namespace
  name: example-user@${aws_eks_cluster.example.name}
current-context: example-user@${aws_eks_cluster.example.name}
users:
- name: example-user
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${aws_eks_cluster.example.name}"
        - "-r"
        - "${aws_iam_role.cluster.arn}"
EOF
}
