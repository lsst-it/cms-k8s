#!/usr/bin/env bash
(
  set -e
  kubectl delete -f telegraf-credentials.yaml
  kubectl delete -f svc-account.yaml
  kubectl delete -f configmap.yaml
  kubectl delete -f role.yaml
  kubectl delete -f role-binding.yaml
  kubectl delete -f service.yaml
  kubectl delete -f deployment.yaml
)
sleep 20
kubectl delete ns it-telegraf
