# EKS Infrastructure on AWS

This directory contains Terraform configuration to deploy a Kubernetes cluster (EKS) with GPU-enabled node groups on AWS.

## Features
- **VPC & Networking**: Custom VPC with public subnet and Internet Gateway.
- **EKS Cluster**: Managed Kubernetes cluster.
- **GPU Node Group**: Auto-scaling group of `g4dn.xlarge` instances (NVIDIA T4) using SPOT capacity.
- **IAM Roles**: Pre-configured roles for cluster and worker nodes with necessary policies (including ECR read-only and EC2 Full Access).

## Prerequisites
- Terraform >= 1.0
- AWS CLI configured with appropriate credentials.

## Deployment
1. Navigate to the directory:
   ```bash
   cd MyReposGitHub/kubernetes/TERRAFORM/terraformAWS
   ```
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Apply the configuration:
   ```bash
   terraform apply
   ```

## Note on LocalStack
The `provider.tf` file is configured for real AWS by default. If you wish to test locally using LocalStack, uncomment the LocalStack endpoint configuration in `provider.tf`.
