#!/usr/bin/env bash
kubectl create ns it-influxdb
(
  set -e
  kubectl apply -f influxdb-credentials.yaml
  kubectl apply -f svc-account.yaml
  kubectl apply -f configmap.yaml
  kubectl apply -f service.yaml
  kubectl apply -f statefulset.yaml
  kubectl apply -f ingress.yaml
  kubectl apply -f job.yaml
)