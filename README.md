# Kubernetes External Secret Azure Vault

Fetching secrets from Azure Key Vault with External Secret
operator into a Kubernetes cluster.

This approach works with both managed Kubernetes clusters,
as well as the self-managed ones.

The implementation here is using the Kubernetes cluster
from K3d.

## Prerequisites

- [K3d v5][K3d]
- [helmfile v0][helmfile]

## Roadmap

- [x] Create the GitHub repository & the deploy key with write permissions
- [x] (Optional) Create the user GPG Key and add it to GitH  ub GPG keys
- [x] Spin up the Kubernetes cluster with the issuer URL of the GitHub pages
- [x] Create a K8s cronjob that fetches the OIDC config and commits them to repo
- [ ] Establish trust relationship from K8s to Azure Key Vault
- [ ] Create the Azure Key Vault and establish OIDC trust with K8s
- [ ] Create User Assigned Identity in Azure and grant read permission to Vault
- [ ] Deploy Azure Workload Identity
- [ ] Deploy External Secret Operator with the pod annotation of tenant-id and client-id
- [ ] Create & fetch a sample secret from Vault into Kubernetes

[helmfile]: https://github.com/helmfile/helmfile/releases/v0.167.1/
[K3d]: https://github.com/k3d-io/k3d/releases/v5.7.3/
