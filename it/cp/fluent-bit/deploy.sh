#!/usr/bin/env bash
set -eox
NAMESPACE='it-fluentbit'
kubectl create ns $NAMESPACE
kubectl apply -n $NAMESPACE -f svc-account.yaml
kubectl apply -n $NAMESPACE -f configmap.yaml
kubectl apply -n $NAMESPACE -f clusterrole.yaml
kubectl apply -n $NAMESPACE -f clusterrolebinding.yaml
kubectl apply -n $NAMESPACE -f svc.yaml
kubectl apply -n $NAMESPACE -f daemonset.yaml
