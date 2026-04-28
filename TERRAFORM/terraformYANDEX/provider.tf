terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "= 0.146" # version provider
    }
  }
  required_version = ">= 1.0"
}

provider "yandex" {
  zone = var.region
}