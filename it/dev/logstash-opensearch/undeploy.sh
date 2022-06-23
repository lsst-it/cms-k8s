#!/usr/bin/env bash

kubectl delete -n opensearch -f logstash/ingress.yaml
kubectl delete -n opensearch -f logstash/statefulset.yaml
kubectl delete -n opensearch -f logstash/svc.yaml
kubectl delete -n opensearch -f logstash/svc-headless.yaml
kubectl delete -n opensearch -f logstash/configmap.yaml
kubectl delete -n opensearch -f logstash/pdb.yaml
kubectl delete -n opensearch -f dashboard/deployment.yaml
kubectl delete -n opensearch -f dashboard/svc.yaml
kubectl delete -n opensearch -f dashboard/rolebinding.yaml
kubectl delete -n opensearch -f dashboard/svc-account.yaml
kubectl delete -n opensearch -f opensearch/statefulset.yaml
kubectl delete -n opensearch -f opensearch/svc-headless.yaml
kubectl delete -n opensearch -f opensearch/svc-master.yaml
kubectl delete -n opensearch -f opensearch/configmap.yaml
kubectl delete -n opensearch -f opensearch/secret.yaml
kubectl delete ns opensearch