#!/usr/bin/env bash

kubectl create ns opensearch
kubectl apply -n opensearch -f opensearch/secret.yaml
kubectl apply -n opensearch -f opensearch/configmap.yaml
kubectl apply -n opensearch -f opensearch/svc-master.yaml
kubectl apply -n opensearch -f opensearch/svc-headless.yaml
kubectl apply -n opensearch -f opensearch/statefulset.yaml
kubectl apply -n opensearch -f dashboard/svc-account.yaml
kubectl apply -n opensearch -f dashboard/rolebinding.yaml
kubectl apply -n opensearch -f dashboard/svc.yaml
kubectl apply -n opensearch -f dashboard/deployment.yaml
kubectl apply -n opensearch -f logstash/configmap.yaml
kubectl apply -n opensearch -f logstash/svc-headless.yaml
kubectl apply -n opensearch -f logstash/svc.yaml
kubectl apply -n opensearch -f logstash/statefulset.yaml
kubectl apply -n opensearch -f dashboard/ingress.yaml
