include "root" {
  path = find_in_parent_folders()
}

inputs = {
  issuer_url = dependency.repository.outputs.github_pages_url
}

dependency "repository" {
  config_path = "../gh-repo"
}
