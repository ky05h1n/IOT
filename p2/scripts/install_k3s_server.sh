#!/usr/bin/env bash
set -euo pipefail
SERVER_IP="${1:-192.168.56.110}"
LOGIN="${2:-mehdi}"
TOKEN="${K3S_TOKEN:-IOTSUPERSECRETTOKEN123}"

apt-get update -y
apt-get install -y curl ca-certificates jq

curl -sfL https://get.k3s.io | \
  INSTALL_K3S_EXEC="server --tls-san ${SERVER_IP} --node-ip ${SERVER_IP} --write-kubeconfig-mode 644" \
  K3S_TOKEN="${TOKEN}" \
  sh -

mkdir -p /home/vagrant/.kube
cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube
chmod 600 /home/vagrant/.kube/config

echo "K3s server installed. API: https://${SERVER_IP}:6443"
echo "Token (server): $(sudo cat /var/lib/rancher/k3s/server/node-token)"
