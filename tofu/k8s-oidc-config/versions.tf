terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.31"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = "~> 0.9"
    }
  }

  required_version = "< 2"
}

provider "kubernetes" {
  config_path    = var.kubeconfig_path
  config_context = var.kubeconfig_context
}

provider "kustomization" {
  kubeconfig_path = var.kubeconfig_path
  context         = var.kubeconfig_context
}
