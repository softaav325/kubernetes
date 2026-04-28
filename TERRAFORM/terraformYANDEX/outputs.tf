output "k8sclaster_id" {
  value = yandex_kubernetes_cluster.klaster_Kubernetes.id
}

output "k8sclaster_ip" {
  value = yandex_kubernetes_cluster.klaster_Kubernetes.master.0.external_v4_endpoint
}

output "subnet_id" {
  value = yandex_vpc_subnet.subnet-k8s.id
}

