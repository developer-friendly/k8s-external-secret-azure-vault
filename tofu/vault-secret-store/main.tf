resource "kubernetes_manifest" "css" {
  manifest = yamldecode(<<-EOF
    apiVersion: external-secrets.io/v1beta1
    kind: ClusterSecretStore
    metadata:
      name: azure-keyvault
    spec:
      provider:
        azurekv:
          authType: WorkloadIdentity
          vaultUrl: ${var.vault_url}
  EOF
  )
}
