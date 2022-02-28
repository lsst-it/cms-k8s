#!/usr/bin/env bash
kubectl create ns it-telegraf
(
  set -e
  kubectl apply -f telegraf-credentials.yaml
  kubectl apply -f svc-account.yaml
  kubectl apply -f configmap.yaml
  kubectl apply -f role.yaml
  kubectl apply -f role-binding.yaml
  kubectl apply -f service.yaml
  kubectl apply -f deployment.yaml
)