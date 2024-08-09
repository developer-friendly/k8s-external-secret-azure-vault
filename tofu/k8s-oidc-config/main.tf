# k8s configmap
resource "kubernetes_config_map" "this" {
  metadata {
    name      = "github"
    namespace = "kube-system"
  }

  data = {
    GITHUB_REPOSITORY = var.github_repository
    COMMIT_NAME       = var.commit_name
    COMMIT_EMAIL      = var.commit_email
  }
}

resource "kubernetes_secret" "this" {
  metadata {
    name      = "github"
    namespace = "kube-system"
  }

  data = {
    "gpg-private-key"   = var.gpg_private_key
    "github-deploy-key" = var.github_deploy_key

  }

  type = "Opaque"
}

data "kustomization_build" "this" {
  path = "./manifests"
}

resource "kustomization_resource" "p0" {
  for_each = data.kustomization_build.this.ids_prio[0]

  manifest = data.kustomization_build.this.manifests[each.value]

  depends_on = [
    kubernetes_secret.this
  ]
}

resource "kustomization_resource" "p1" {
  for_each = data.kustomization_build.this.ids_prio[1]

  manifest = data.kustomization_build.this.manifests[each.value]

  wait = true
  timeouts {
    create = "2m"
    update = "2m"
  }

  depends_on = [kustomization_resource.p0]
}

resource "kustomization_resource" "p2" {
  for_each = data.kustomization_build.this.ids_prio[2]

  manifest = data.kustomization_build.this.manifests[each.value]

  depends_on = [kustomization_resource.p1]
}
