#!/usr/bin/env sh

set -eux

repo_name=$(date +%s)

git clone "$GITHUB_REPOSITORY" "$repo_name"

cd "$repo_name"

mkdir -p ./openid/v1 ./.well-known

kubectl get --raw /openid/v1/jwks > ./openid/v1/jwks
kubectl get --raw /.well-known/openid-configuration > ./.well-known/openid-configuration

if [ -z "$(git status --porcelain)" ]; then
    echo "No changes to commit"
    exit 0
fi

git add .

gpg --import /gpg-private-key

git config --global user.name "$COMMIT_NAME"
git config --global user.email "${COMMIT_EMAIL}"
git config --global commit.gpgsign true

date_isoformat=$(date -Iseconds)
git commit -m "Update JWKS at $date_isoformat"

git push origin main
