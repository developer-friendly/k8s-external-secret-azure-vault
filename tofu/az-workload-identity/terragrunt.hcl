include "root" {
  path = find_in_parent_folders()
}

inputs = {
}

dependency "k8s" {
  config_path  = "../k8s-cluster"
  skip_outputs = true
}
