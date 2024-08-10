locals {
  secret_name = "pgpassword"
}

resource "random_password" "this" {
  length  = 32
  special = false
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"
}

resource "azurerm_key_vault_secret" "this" {
  name         = module.naming.key_vault_secret.name_unique
  value        = random_password.this.result
  key_vault_id = var.key_vault_id

  content_type = "password"

  expiration_date = "2030-12-31T23:59:59Z"
}

resource "kubernetes_manifest" "this" {
  manifest = yamldecode(<<-EOF
  apiVersion: external-secrets.io/v1beta1
  kind: ExternalSecret
  metadata:
    name: ${local.secret_name}
    namespace: name
  spec:
    data:
      - remoteRef:
          key: ${azurerm_key_vault_secret.this.name}
        secretKey: PGPASSWORD
    refreshInterval: 1h
    secretStoreRef:
      kind: ClusterSecretStore
      name: azure-keyvault
    EOF
  )
}

resource "kubernetes_job" "this" {
  metadata {
    name      = "demo"
    namespace = "default"
  }

  spec {
    template {
      metadata {
        labels = {
          app = "demo"
        }
      }
      spec {
        container {
          name    = "demo"
          image   = "busybox:1"
          command = ["sh", "-c", "set eu; echo $PGPASSWORD"]
          env_from {
            secret_ref {
              name = local.secret_name
            }
          }
        }
      }
    }
    parallelism                = 1
    completions                = 1
    backoff_limit              = 1
    ttl_seconds_after_finished = 86400
  }

  depends_on = [
    azurerm_key_vault_secret.this,
    kubernetes_manifest.this,
  ]

  lifecycle {
    replace_triggered_by = [
      kubernetes_manifest.this.id,
    ]
  }
}
