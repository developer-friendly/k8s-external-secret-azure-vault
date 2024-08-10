variable "kubeconfig_path" {
  type    = string
  default = "~/.kube/config"
}

variable "kubeconfig_context" {
  type    = string
  default = "k3d-k8s"
}

variable "key_vault_id" {
  type     = string
  nullable = false
}
