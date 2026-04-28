variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "k8s-gpu-project"
}
