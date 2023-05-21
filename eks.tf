resource "aws_eks_cluster" "example" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids = [aws_subnet.example_a.id, aws_subnet.example_b.id]
  }

  depends_on = [
    aws_subnet.example_a,
    aws_subnet.example_b,
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.ClusterIAMFullAccess,
  ]
}

resource "aws_eks_node_group" "example" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-nodes"
  node_role_arn   = aws_iam_role.workers.arn
  subnet_ids      = [aws_subnet.example_a.id, aws_subnet.example_b.id]

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = [var.instance_type]

  depends_on = [
    aws_subnet.example_a,
    aws_subnet.example_b,
    aws_eks_cluster.example,
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.WorkersIAMFullAccess,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
}

resource "local_file" "kubeconfig" {
  content = templatefile("kubeconfig.tpl", {
    endpoint                   = aws_eks_cluster.example.endpoint
    certificate_authority_data = aws_eks_cluster.example.certificate_authority.0.data
    cluster_name               = aws_eks_cluster.example.name
  })
  filename = "${path.module}/kubeconfig.yaml"

  depends_on = [
    aws_eks_cluster.example
  ]
}