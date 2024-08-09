variable "gpg_private_key" {
  type      = string
  sensitive = true
  nullable  = false
}

variable "github_deploy_key" {
  type      = string
  sensitive = true
  nullable  = false
}

variable "kubeconfig_path" {
  type    = string
  default = "~/.kube/config"
}

variable "kubeconfig_context" {
  type    = string
  default = "k3d-k8s"
}

variable "github_repository" {
  type     = string
  nullable = false
}

variable "commit_name" {
  type     = string
  nullable = false
}

variable "commit_email" {
  type     = string
  nullable = false
}
