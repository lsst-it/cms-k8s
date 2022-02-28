#!/usr/bin/env bash
kubectl create ns it-grafana
(
  set -e
  kubectl apply -f influxdb-credentials.yaml
  kubectl apply -f grafana-credentials.yaml
  kubectl apply -f ldap-secret.yaml
  kubectl apply -f pod-security-policy.yaml
  kubectl apply -f svc-account.yaml
  kubectl apply -f configmap.yaml
  kubectl apply -f cluster-role.yaml
  kubectl apply -f cluster-role-binding.yaml
  kubectl apply -f role.yaml
  kubectl apply -f role-binding.yaml
  kubectl apply -f service.yaml
  kubectl apply -f deployment.yaml
  kubectl apply -f ingress.yaml
)