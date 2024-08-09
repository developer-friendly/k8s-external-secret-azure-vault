terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.2"
    }
    gpg = {
      source  = "Olivr/gpg"
      version = "~> 0.2"
    }
  }

  required_version = "< 2"
}

provider "github" {
  owner = var.github_owner
}
