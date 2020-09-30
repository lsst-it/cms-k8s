#!/usr/bin/env bash
kubectl create ns it-grafana
( set -e
  kubectl apply -f grafana/grafana-credentials.yaml
  kubectl apply -f grafana/ldap-secret.yaml
  kubectl apply -f grafana/pod-security-policy.yaml
  kubectl apply -f grafana/svc-account.yaml
  kubectl apply -f grafana/configmap.yaml
  kubectl apply -f grafana/cluster-role.yaml
  kubectl apply -f grafana/cluster-role-binding.yaml
  kubectl apply -f grafana/role.yaml
  kubectl apply -f grafana/role-binding.yaml
  kubectl apply -f grafana/service.yaml
  kubectl apply -f grafana/deployment.yaml
  kubectl apply -f grafana/ingress.yaml
)