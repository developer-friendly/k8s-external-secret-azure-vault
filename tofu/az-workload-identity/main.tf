data "azurerm_client_config" "current" {}

resource "helm_release" "this" {
  name       = "azure-workload-identity"
  repository = "https://azure.github.io/azure-workload-identity/charts"
  chart      = "workload-identity-webhook"
  version    = "1.3.x"

  namespace        = "azure-workload-identity-system"
  create_namespace = true

  values = [
    <<-EOF
      azureTenantID: "${data.azurerm_client_config.current.tenant_id}"
    EOF
  ]
}
