# Kubernetes External Secret Azure Vault

Fetching secrets from Azure Key Vault with External Secret
operator into a Kubernetes cluster.

This approach works with both managed Kubernetes clusters,
as well as the self-managed ones.

The implementation here is using the Kubernetes cluster
from Docker Desktop.

## TODO

- [ ] Create the GitHub repository & the deploy key with write permissions
- [ ] Spin up the Kubernetes cluster with the issuer URL of the GitHub pages
- [ ] Create the GPG Key and add it to user's GPG keys
- [ ] Create a shell script that fetches the OIDC config and commits them to repo
- [ ] Establish trust relationship from K8s to Azure Key Vault
- [ ] Create User Assigned Identity in Azure and grant read permission to Vault
- [ ] Deploy Azure Workload Identity
- [ ] Deploy External Secret Operator with the pod annotation of tenant-id and client-id
- [ ] Create & fetch a sample secret from Vault into Kubernetes
