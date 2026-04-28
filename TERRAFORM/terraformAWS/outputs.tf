output "cluster_endpoint" {
  value = aws_eks_cluster.klaster_kubernetes.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.klaster_kubernetes.name
}

output "vpc_id" {
  value = aws_vpc.vpc_k8s.id
}
