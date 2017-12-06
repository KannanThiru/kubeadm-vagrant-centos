#!/bin/bash

# For CentOS/Fedora users, try
yum install ebtables ethtool

# Install Docker
yum install -y docker
systemctl enable docker && systemctl start docker

# Install Kubeadm etc
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
        https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
setenforce 0
yum install -y kubelet kubeadm kubectl
systemctl enable kubelet && systemctl start kubelet

sudo sysctl net.bridge.bridge-nf-call-iptables=1
