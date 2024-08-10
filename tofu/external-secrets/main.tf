resource "helm_release" "this" {
  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "0.10.x"

  namespace        = "external-secrets"
  create_namespace = true

  values = [
    <<-EOF
      serviceAccount:
        annotations:
          azure.workload.identity/client-id: ${azurerm_user_assigned_identity.this.client_id}
          azure.workload.identity/tenant-id: ${data.azurerm_client_config.current.tenant_id}
      podLabels:
        azure.workload.identity/use: "true"
    EOF
  ]
}
