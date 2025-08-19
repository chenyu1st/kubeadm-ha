#!/bin/bash
set -eux;

# 添加kubernetes源
cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=0
repo_gpgcheck=0
EOF

case "${1:-centos7}" in
  centos7|centos8)
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
    ;;
esac

case "${1:-centos7}" in
  kylin10|uos)
    # Do Nothing
    ;;
  openeuler)
    yum install -y findutils createrepo
    ;;
  *)
    yum install -y yum-utils createrepo
    ;;
esac

packages=(
    socat
    ipset
    ipvsadm
    nmap-ncat
    nfs-utils
    iscsi-initiator-utils
    conntrack-tools
    bash-completion
    kubeadm-1.30.14
    kubectl-1.30.14
    kubelet-1.30.14
)

if [ ! -d 'packages' ]; then
  (
    echo 'keepcache=1' >> /etc/yum.conf
    mkdir packages
    chmod 0777 packages
    cd packages
    repotrack ${packages[*]} || true
    yumdownloader --resolve ${packages[*]} || true
    yum install -y --downloadonly ${packages[*]}
    cp -rf `find /var/cache/{yum,dnf} -name '*.rpm'` .
  )
  createrepo --update packages || true
fi

case "${1:-centos7}" in
  centos8|anolis8|almalinux)
    yum install -y modulemd-tools
    createrepo --update packages || true
    repo2module -n timebye -s stable packages packages/repodata/modules.yaml
    modifyrepo_c --mdtype=modules packages/repodata/modules.yaml packages/repodata
    ;;
esac