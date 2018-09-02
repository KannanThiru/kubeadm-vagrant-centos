#!/bin/bash

ADDRESS="$(ip -4 addr show eth1 | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
HOSTNAME=`hostname`
sudo sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

sudo sed -i -e 's/AUTHZ_ARGS=.*/AUTHZ_ARGS="/' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

sudo systemctl daemon-reload
sudo kubeadm join --ignore-preflight-errors=all --token a7da6c.4566sfsg56rb3456 192.168.56.101:6443 --discovery-token-unsafe-skip-ca-verification
