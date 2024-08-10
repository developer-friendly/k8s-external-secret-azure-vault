include "root" {
  path = find_in_parent_folders()
}

inputs = {
  issuer_url = dependency.gh_repo.outputs.github_pages_url

  resource_group_name = dependency.vault.outputs.resource_group_name
  location            = dependency.vault.outputs.location
  key_vault_id        = dependency.vault.outputs.key_vault_id
}

dependency "k8s" {
  config_path = "../k8s-cluster"
}

dependency "vault" {
  config_path = "../az-key-vault"
}

dependency "gh_repo" {
  config_path = "../gh-repo"
}

dependency "az_workload_identity" {
  config_path = "../az-workload-identity"
}
