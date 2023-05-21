provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-1.21-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI account ID
}

resource "aws_eks_cluster" "example" {
  name     = "example"
  role_arn = aws_iam_role.example.arn

  vpc_config {
    subnet_ids = [aws_subnet.example.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
  ]
}

resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "example"
  node_role_arn   = aws_iam_role.example.arn
  subnet_ids      = [aws_subnet.example.id]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  remote_access {
    ec2_ssh_key = "example"
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
  ]
}

# Cria Kubeconfig
resource "local_file" "kubeconfig" {
 content = templatefile("kubeconfig.tpl", {
   endpoint                   = aws_eks_cluster.this.endpoint
   certificate_authority_data = aws_eks_cluster.this.certificate_authority.0.data
   cluster_name               = aws_eks_cluster.this.name
 })
 filename = "${path.module}/kubeconfig.yaml"
}