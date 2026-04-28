// Roles for service account
resource "yandex_resourcemanager_folder_iam_member" "k8s_roles" {
  for_each = toset([
    "k8s.admin",                     # Initially, the service account uses cluster-admin for infrastructure provisioning, but for the ML-application, a granular RBAC Role was created to follow the Principle of Least Privilege (PoLP)
    "k8s.cluster-api.cluster-admin", # Full access to the API within the cluster
    "vpc.publicAdmin",
    "compute.editor", # Needed to create interruptible nodes and GPUs
    // Best practics create new account 
    "k8s.clusters.agent",
    "container-registry.images.puller",
    // optional
    // "storage.editor",
    // "load-balancer.admin",
  ])
  folder_id = var.folder
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.sa-k8s.id}"
}
