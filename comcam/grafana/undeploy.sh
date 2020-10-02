#!/usr/bin/env bash
(
  set -e
  kubectl delete -f deployment.yaml
  kubectl delete -f service.yaml
  kubectl delete -f role-binding.yaml
  kubectl delete -f role.yaml
  kubectl delete -f cluster-role-binding.yaml
  kubectl delete -f cluster-role.yaml
  kubectl delete -f configmap.yaml
  kubectl delete -f svc-account.yaml
  kubectl delete -f pod-security-policy.yaml
  kubectl delete -f ldap-secret.yaml
  kubectl delete -f grafana-credentials.yaml
  kubectl delete -f influxdb-credentials.yaml
)