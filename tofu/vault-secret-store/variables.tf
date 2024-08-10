variable "vault_url" {
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
