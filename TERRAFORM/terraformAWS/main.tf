locals {
  nameklaster = "k8s"
  namegpu     = "gpu-autoscale-group"
  version     = "1.32" # EKS version
}

# Create EKS Cluster
resource "aws_eks_cluster" "klaster_kubernetes" {
  name     = local.nameklaster
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet_k8s.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

# Group of GPU nodes with auto-scaling
resource "aws_eks_node_group" "gpu_node_group" {
  cluster_name    = aws_eks_cluster.klaster_kubernetes.name
  node_group_name = local.namegpu
  node_role_arn   = aws_iam_role.eks_nodes_role.arn
  subnet_ids      = [aws_subnet.subnet_k8s.id]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 0
  }

  # Using g4dn.xlarge for NVIDIA T4 GPU (equivalent to GPU instances in YC)
  instance_types = ["g4dn.xlarge"]

  # Spot instances (equivalent to preemptible in YC)
  capacity_type = "SPOT"

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_registry_policy,
  ]
}




