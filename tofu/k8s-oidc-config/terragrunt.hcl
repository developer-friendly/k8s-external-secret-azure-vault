include "root" {
  path = find_in_parent_folders()
}

inputs = {
  gpg_private_key   = dependency.gpg_key.outputs.gpg_private_key
  github_deploy_key = dependency.gh_repo.outputs.deploy_private_key
  github_repository = dependency.gh_repo.outputs.repository_ssh_url
  commit_name       = dependency.gpg_key.outputs.gpg_name
  commit_email      = dependency.gpg_key.outputs.gpg_email
}

dependency "gpg_key" {
  config_path = "../user-gpg-key"
}

dependency "gh_repo" {
  config_path = "../gh-repo"
}
