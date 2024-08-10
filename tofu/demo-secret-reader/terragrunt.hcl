include "root" {
  path = find_in_parent_folders()
}

inputs = {
  key_vault_id = dependency.vault.outputs.key_vault_id
}

dependency "external_secrets" {
  config_path = "../external-secrets"
}

dependency "vault" {
  config_path = "../az-key-vault"
}
