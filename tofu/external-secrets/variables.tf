variable "resource_group_name" {
  type     = string
  nullable = false
}

variable "location" {
  type     = string
  nullable = false
}

variable "issuer_url" {
  type     = string
  nullable = false
}

variable "key_vault_id" {
  type     = string
  nullable = false
}

variable "kubeconfig_path" {
  type    = string
  default = "~/.kube/config"
}

variable "kubeconfig_context" {
  type    = string
  default = "k3d-k8s"
}
