output "gpg_private_key" {
  value     = gpg_private_key.this.private_key
  sensitive = true
}

output "gpg_email" {
  value = gpg_private_key.this.email
}

output "gpg_name" {
  value = gpg_private_key.this.name
}
