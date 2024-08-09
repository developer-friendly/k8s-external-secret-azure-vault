resource "random_pet" "this" {
  length = 4
}

resource "github_repository" "this" {
  name = random_pet.this.id

  visibility = "public"

  vulnerability_alerts = true

  auto_init = true

  homepage_url = "https://${var.github_owner}.github.io/${random_pet.this.id}"

  pages {
    build_type = "workflow"

    source {
      branch = "main"
      path   = "/"
    }
  }
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "github_repository_deploy_key" "this" {
  title      = "K8s deploy key"
  repository = github_repository.this.name
  key        = tls_private_key.this.public_key_openssh
  read_only  = false
}

resource "github_repository_file" "this" {
  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/ci.yml"
  content             = file("${path.module}/files/ci.yml")
  commit_message      = "Managed by OpenTofu"
  commit_author       = var.commit_name
  commit_email        = var.commit_email
  overwrite_on_create = false
}
