#!/usr/bin/env bash
set -euo pipefail
SERVER_IP="${1:-192.168.56.110}"
WORKER_IP="${2:-192.168.56.111}"
LOGIN="${3:-mehdi}"
TOKEN="${K3S_TOKEN:-IOTSUPERSECRETTOKEN123}"

apt-get update -y
apt-get install -y curl ca-certificates

for i in {1..60}; do
  if curl -sk --max-time 2 "https://${SERVER_IP}:6443/readyz" >/dev/null; then
    break
  fi
  sleep 2
done

curl -sfL https://get.k3s.io | \
  INSTALL_K3S_EXEC="agent --server https://${SERVER_IP}:6443 --with-node-id --node-ip ${WORKER_IP}" \
  K3S_TOKEN="${TOKEN}" \
  sh -

echo "K3s agent installed and joined https://${SERVER_IP}:6443"
