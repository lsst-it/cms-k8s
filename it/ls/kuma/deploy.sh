#!/usr/bin/env bash
set -e

kubectl create ns it-kuma
kubectl apply -f resources/svc.yaml
kubectl apply -f resources/pvc.yaml
kubectl apply -f resources/deployment.yaml
kubectl apply -f resources/ingress.yaml