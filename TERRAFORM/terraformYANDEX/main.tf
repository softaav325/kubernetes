locals {
  zone        = "ru-central1-a"
  saname      = "sa-k8s"
  nameklaster = "k8s"
  namegpu     = "gpu-autoscale-group"
  version     = "1.32"
}

// Create service account
resource "yandex_iam_service_account" "sa-k8s" {
  name      = local.saname
  folder_id = var.folder
}

// Create kuberbnetes kluster
resource "yandex_kubernetes_cluster" "klaster_Kubernetes" {
  network_id = yandex_vpc_network.vpc-k8s.id
  name       = local.nameklaster
  folder_id  = var.folder
  master {
    version = local.version
    master_location {
      zone      = yandex_vpc_subnet.subnet-k8s.zone
      subnet_id = yandex_vpc_subnet.subnet-k8s.id
    }
    public_ip = true
  }
  release_channel         = "RAPID"
  service_account_id      = yandex_iam_service_account.sa-k8s.id
  node_service_account_id = yandex_iam_service_account.sa-k8s.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_roles
  ]
}

// Group of interruptible GPU nodes with auto-scaling
resource "yandex_kubernetes_node_group" "gpu_node_group" {
  description = "nodes for project"
  cluster_id  = yandex_kubernetes_cluster.klaster_Kubernetes.id
  name        = local.namegpu
  version     = local.version

  instance_template {
    platform_id = "gpu-standard-v1" # Platform with NVIDIA Tesla V100

    resources {
      memory = 32
      cores  = 8
      gpus   = 1 # Counts GPU
    }

    boot_disk {
      type = "network-ssd"
      size = 100
    }

    scheduling_policy {
      preemptible = true # Spot nodes
    }

    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.subnet-k8s.id}"]
    }
  }

  scale_policy {
    auto_scale {
      min     = 0
      max     = 3
      initial = 1
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }
}

// Generate key json for service account k8s
resource "local_file" "keyk8s" {
  filename = "keygen.sh"
  content = templatefile("key-gen.json.tpl", {
    id_SA = yandex_iam_service_account.sa-k8s.id
  })
}
