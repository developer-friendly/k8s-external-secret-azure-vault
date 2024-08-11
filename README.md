# Kubernetes External Secret Azure Vault

Fetching secrets from Azure Key Vault with External Secret
operator into a Kubernetes cluster.

This approach works with both managed Kubernetes clusters,
as well as the self-managed ones.

The implementation here is using the Kubernetes cluster
from K3d.

## Prerequisites

- [K3d v5][K3d]
- [Opentofu v1.8][opentofu]
- [Terragrunt v0.66][terragrunt]

## Diagram

```mermaid
sequenceDiagram
    participant Pod
    participant IdP as Identity Provider
    participant Service Provider

    Service Provider-->>IdP: Trust Relationship<br/>GET https://example.com/.well-known/openid-configuration

    rect rgba(0, 0, 0, 0.1)
    note right of Pod: Kubernetes
    Pod->>IdP: Get ServiceAccount token
    IdP->>Pod: Mount ServiceAccount token
    end

    Pod->>Service Provider: Request Access + token

    Service Provider->>IdP: Validate Token<br/>GET https://example.com/.well-known/openid/v1/jwks
    IdP->>Service Provider: Token Validation Response
    Service Provider->>Pod: Access Granted
```

## Roadmap

- [x] Create the GitHub repository & the deploy key with write permissions
- [x] (Optional) Create the user GPG Key and add it to GitHub user GPG keys
- [x] Spin up the Kubernetes cluster with the issuer URL of the GitHub pages
- [x] Create a K8s cronjob that fetches the OIDC config and commits them to repo
- [x] Create the Azure Key Vault & the managed identity plus the credentials
- [x] Deploy Azure Workload Identity
- [x] Deploy External Secret Operator with the pod annotation of tenant-id and client-id
- [x] Create & fetch a sample secret from Vault into Kubernetes

## Stacks

The following are the Terragrunt dependency stacks:

Group 1
- tofu/az-key-vault
- tofu/gh-repo
- tofu/user-gpg-key

Group 2
- tofu/k8s-cluster
- tofu/k8s-oidc-config

Group 3
- tofu/az-workload-identity

Group 4
- tofu/external-secrets

Group 5
- tofu/demo-secret-reader
- tofu/vault-secret-store

[K3d]: https://github.com/k3d-io/k3d/releases/v5.7.3/
[opentofu]: https://github.com/opentofu/opentofu/releases/v1.8.1/
[terragrunt]: https://github.com/gruntwork-io/terragrunt/releases/v0.66.3/
