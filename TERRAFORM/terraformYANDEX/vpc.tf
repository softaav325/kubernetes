# ------------- Create resource network -----------------------
resource "yandex_vpc_network" "vpc-k8s" {
  name      = "network-k8s"
  folder_id = var.folder
}

# ------------- Create resource subnet -----------------------
resource "yandex_vpc_subnet" "subnet-k8s" {
  zone           = local.zone
  folder_id      = var.folder
  network_id     = yandex_vpc_network.vpc-k8s.id
  v4_cidr_blocks = ["192.168.0.0/24"]
}
