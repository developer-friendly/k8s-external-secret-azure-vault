generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    terraform {
      backend "remote" {
        hostname     = "app.terraform.io"
        organization = "developer-friendly"

        workspaces {
          name = "${basename(get_terragrunt_dir())}"
        }
      }
    }
  EOF
}
