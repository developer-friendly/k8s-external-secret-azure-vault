[no-cd]
init:
  terragrunt init -upgrade

[no-cd]
plan:
  terragrunt plan -out tfplan

[no-cd]
apply:
  terragrunt apply tfplan

boot:
  minikube start --memory 8192 --cpus 4 --kubernetes-version=v1.30.2 \
    --extra-config=apiserver.service-account-jwks-uri=https://example.com/openid/v1/jwks \
    --extra-config=apiserver.service-account-issuer=https://example.com
