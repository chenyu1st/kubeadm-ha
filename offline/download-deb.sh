#/bin/bash
set -eux;

(
  # 创建缓存目录
  mkdir packages
  chmod 0777 packages
  cd packages

  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y ca-certificates curl gnupg software-properties-common apt-transport-https dpkg-dev

  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list

  apt-get update

  apt-get -d install -y \
    socat \
    ipset \
    ipvsadm \
    conntrack \
    net-tools \
    nfs-common \
    libseccomp2 \
    netcat-openbsd \
    ca-certificates \
    bash-completion \
    apt-transport-https \
    software-properties-common

  # 下载k8s
  # 查询版本号apt-cache madison kubeadm | awk '{ print $3 }'
  apt-get -d install -y \
    kubeadm=1.30.5-1.1 \
    kubectl=1.30.5-1.1 \
    kubelet=1.30.5-1.1 \
    kubernetes-cni=1.4.0-1.1

  mv /var/cache/apt/archives/*.deb .
)

dpkg-scanpackages packages > packages/Packages