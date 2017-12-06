#!/bin/bash

cat > /etc/systemd/system/kubelet.service.d/01-kubeadm.conf <<EOF
[Service]
Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"
EOF

ADDRESS="$(ip -4 addr show eth1 | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
HOSTNAME=`hostname`
sudo sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts
sudo sed -e '/^.*ubuntu-xenial.*/d' -i /etc/hosts

sudo sed -i -e 's/AUTHZ_ARGS=.*/AUTHZ_ARGS="/' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

sudo systemctl daemon-reload
sudo kubeadm join --skip-preflight-checks --token=b9e6bb.6746bcc9f8ef8267 a7da6c.4566sfsg56rb3456
