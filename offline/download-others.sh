#!/bin/bash
set -eux;

case "${1:-amd64}" in
  amd64|x86_64)
    curl -Lo packages/runc https://github.com/opencontainers/runc/releases/download/v1.2.2/runc.amd64;
    curl -Lo packages/containerd.tar.gz https://github.com/containerd/containerd/releases/download/v1.7.24/containerd-1.7.24-linux-amd64.tar.gz;
    curl -Lo packages/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-25.0.5.tgz;
    curl -Lo packages/cri-dockerd.tgz https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.16/cri-dockerd-0.3.16.amd64.tgz;
    curl -Lo packages/helm.tar.gz https://get.helm.sh/helm-v3.16.4-linux-amd64.tar.gz;
    ;;
  arm64|aarch64)
    curl -Lo packages/runc https://github.com/opencontainers/runc/releases/download/v1.2.2/runc.arm64;
    curl -Lo packages/containerd.tar.gz https://github.com/containerd/containerd/releases/download/v1.7.24/containerd-1.7.24-linux-arm64.tar.gz;
    curl -Lo packages/docker.tgz https://download.docker.com/linux/static/stable/aarch64/docker-25.0.5.tgz;
    curl -Lo packages/cri-dockerd.tgz https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.16/cri-dockerd-0.3.16.arm64.tgz;
    curl -Lo packages/helm.tar.gz https://get.helm.sh/helm-v3.16.4-linux-arm64.tar.gz;
    ;;
esac