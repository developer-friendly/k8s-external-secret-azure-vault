include "root" {
  path = find_in_parent_folders()
}

inputs = {
  vault_url = dependency.vault.outputs.key_vault_uri
}

dependency "vault" {
  config_path = "../az-key-vault"
}

dependency "external_secrets" {
  config_path = "../external-secrets"
}
