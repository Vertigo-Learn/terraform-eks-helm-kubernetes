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
}

output "kubeconfig" {
  description = "Kubeconfig for the example user"
  value = <<EOF
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority-data: ${var.cluster_certificate_authority_data}
    server: ${var.cluster_endpoint}
  name: ${var.cluster_name}
contexts:
- context:
    cluster: ${var.cluster_name}
    user: example-user
    namespace: example-namespace
  name: example-user@${var.cluster_name}
current-context: example-user@${var.cluster_name}
users:
- name: example-user
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster_name}"
        - "-r"
        - "${var.role_arn}"
EOF
}