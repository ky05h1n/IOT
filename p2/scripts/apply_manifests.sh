#!/usr/bin/env bash
set -euo pipefail
echo "Waiting for Kubernetes API..."
for i in {1..60}; do
  if kubectl get nodes >/dev/null 2>&1; then break; fi
  sleep 2
done

kubectl apply -f /vagrant/confs/k8s/app1-deployment.yaml
kubectl apply -f /vagrant/confs/k8s/app1-service.yaml
kubectl apply -f /vagrant/confs/k8s/app2-deployment.yaml
kubectl apply -f /vagrant/confs/k8s/app2-service.yaml
kubectl apply -f /vagrant/confs/k8s/app3-deployment.yaml
kubectl apply -f /vagrant/confs/k8s/app3-service.yaml
kubectl apply -f /vagrant/confs/k8s/ingress.yaml

echo "All manifests applied."
kubectl get deploy,svc,ingress -o wide
