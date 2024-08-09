locals {
  k3d_config = templatefile("${path.module}/templates/k3d-config.yml.tftpl", {
    issuer_url = var.issuer_url
  })
}


resource "local_file" "k3d_config" {
  content         = local.k3d_config
  filename        = "${path.root}/.terraform/tmp/${timestamp()}.yml"
  file_permission = 0640
}


resource "null_resource" "k3d_start" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "k3d cluster create -c ${local_file.k3d_config.filename}"
  }
}
