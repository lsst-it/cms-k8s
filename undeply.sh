#!/usr/bin/env bash
set -e
kubectl delete -f grafana/ingress.yaml
kubectl delete -f grafana/deployment.yaml
kubectl delete -f grafana/service.yaml
kubectl delete -f grafana/role-binding.yaml
kubectl delete -f grafana/role.yaml
kubectl delete -f grafana/cluster-role-binding.yaml
kubectl delete -f grafana/cluster-role.yaml
kubectl delete -f grafana/configmap.yaml
kubectl delete -f grafana/svc-account.yaml
kubectl delete -f grafana/pod-security-policy.yaml
kubectl delete -f grafana/ldap-secret.yaml
kubectl delete -f grafana/grafana-credentials.yaml
kubectl delete ns it-grafana