resource "gpg_private_key" "this" {
  name       = var.gpg_name
  email      = var.gpg_email
  passphrase = var.gpg_passphrase
  rsa_bits   = 3072
}

resource "github_user_gpg_key" "this" {
  armored_public_key = gpg_private_key.this.public_key
}
