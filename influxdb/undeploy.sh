#!/usr/bin/env bash
(
  set -e
  kubectl delete -f influxdb-credentials.yaml
  kubectl delete -f svc-account.yaml
  kubectl delete -f configmap.yaml
  kubectl delete -f service.yaml
  kubectl delete -f statefulset.yaml
  kubectl delete -f ingress.yaml
  kubectl delete -f job.yaml
)