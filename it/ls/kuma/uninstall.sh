#!/usr/bin/env bash
set -e

kubectl delete -f resources/ingress.yaml
kubectl delete -f resources/svc.yaml
kubectl delete -f resources/deployment.yaml
kubectl delete -f resources/pvc.yaml
kubectl delete ns it-kuma