# Yandex Cloud EKS Infrastructure

This directory contains Terraform configuration to deploy a Managed Kubernetes cluster with GPU nodes in Yandex Cloud.

## Features
- **Networking**: Custom VPC and subnet.
- **K8s Cluster**: Managed Kubernetes cluster with a public master endpoint.
- **GPU Node Group**: Auto-scaling group of interruptible (preemptible) nodes with NVIDIA Tesla V100 GPUs.
- **IAM**: Service account with necessary roles (`k8s.admin`, `vpc.publicAdmin`, `compute.editor`, etc.) for cluster management.
- **Key Generation**: Automatic generation of a script/template for the service account key.

## Prerequisites
- Terraform >= 1.0
- Yandex Cloud account and CLI configured.
- Valid `cloud_id` and `folder_id` in `variables.tf`.

## Deployment
1. Navigate to the directory:
   ```bash
   cd MyReposGitHub/kubernetes/TERRAFORM/terraformYANDEX
   ```
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Apply the configuration:
   ```bash
   terraform apply
   ```

## Outputs
- `k8sclaster_id`: The ID of the deployed cluster.
- `k8sclaster_ip`: The external IP of the Kubernetes master.
- `subnet_id`: The ID of the created subnet.
- A file `keygen.sh` will be created locally to help generate the service account key.
