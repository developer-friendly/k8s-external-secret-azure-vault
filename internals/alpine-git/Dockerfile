# checkov:skip=CKV_DOCKER_2: Ensure that HEALTHCHECK instructions have been added to container images

FROM alpine/git:2.45.2

LABEL org.opencontainers.image.source=https://github.com/developer-friendly/k8s-external-secret-azure-vault
LABEL org.opencontainers.image.description="Alpine git Docker image with kubectl & gnupg installed"

RUN apk add --no-cache curl gnupg && \
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
  install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
  rm kubectl && \
  addgroup -g 1000 -S appuser && \
  adduser -u 1000 -S -G appuser appuser

USER 1000:1000
