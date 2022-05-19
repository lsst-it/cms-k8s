#!/usr/bin/env bash
set -eox

NAMESPACE='it-fluentbit'

kubectl delete -n $NAMESPACE -f daemonset.yaml
kubectl delete -n $NAMESPACE -f svc.yaml
kubectl delete -n $NAMESPACE -f clusterrolebinding.yaml
kubectl delete -n $NAMESPACE -f clusterrole.yaml
kubectl delete -n $NAMESPACE -f configmap.yaml
kubectl delete -n $NAMESPACE -f svc-account.yaml
kubectl delete ns $NAMESPACE
