#!/bin/bash
set -eux;

mkdir -p base/{docker,containerd}

case "${1:-amd64}" in
  amd64|x86_64)
    curl -Lo base/runc https://github.com/opencontainers/runc/releases/download/v1.2.2/runc.amd64;
    curl -Lo base/containerd.tar.gz https://github.com/containerd/containerd/releases/download/v1.7.25/containerd-1.7.24-linux-amd64.tar.gz;
    curl -Lo base/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-25.0.5.tgz;
    curl -Lo base/cri-dockerd.tgz https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.16/cri-dockerd-0.3.16.amd64.tgz;
    curl -Lo base/helm.tar.gz https://get.helm.sh/helm-v3.16.4-linux-amd64.tar.gz;
    ;;
  arm64|aarch64)
    curl -Lo base/runc https://github.com/opencontainers/runc/releases/download/v1.2.2/runc.arm64;
    curl -Lo base/containerd.tar.gz https://github.com/containerd/containerd/releases/download/v1.7.25/containerd-1.7.24-linux-arm64.tar.gz;
    curl -Lo base/docker.tgz https://download.docker.com/linux/static/stable/aarch64/docker-25.0.5.tgz;
    curl -Lo base/cri-dockerd.tgz https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.16/cri-dockerd-0.3.16.arm64.tgz;
    curl -Lo base/helm.tar.gz https://get.helm.sh/helm-v3.16.4-linux-arm64.tar.gz;
    ;;
esac

cp roles/prepare/container-engine/templates/cri-dockerd/cri-dockerd.service.j2 base/docker/cri-dockerd.service
cp roles/prepare/container-engine/templates/cri-dockerd/cri-dockerd.socket.j2  base/docker/cri-dockerd.socket

cp roles/prepare/container-engine/templates/docker/config.toml.j2              base/docker/config.toml
cp roles/prepare/container-engine/templates/docker/containerd.service.j2       base/docker/containerd.service
cp roles/prepare/container-engine/templates/docker/docker.service.j2           base/docker/docker.service
cp roles/prepare/container-engine/templates/docker/docker.socket.j2            base/docker/docker.socket

cp roles/prepare/container-engine/templates/containerd/containerd.service.j2   base/containerd/containerd.service
