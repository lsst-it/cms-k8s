#!/usr/bin/env bash
kubectl apply -n it-monitoring -f graylog/secret.yaml
kubectl apply -n it-monitoring -f elasticsearch/configmap.yaml
kubectl apply -n it-monitoring -f mongodb-replicaset/mongodb-init-configmap.yaml
kubectl apply -n it-monitoring -f mongodb-replicaset/mongodb-mongodb-configmap.yaml
kubectl apply -n it-monitoring -f graylog/configmap.yaml
kubectl apply -n it-monitoring -f elasticsearch/client-serviceaccount.yaml
kubectl apply -n it-monitoring -f elasticsearch/data-serviceaccount.yaml
kubectl apply -n it-monitoring -f elasticsearch/master-serviceaccount.yaml
kubectl apply -n it-monitoring -f graylog/serviceaccount.yaml
kubectl apply -n it-monitoring -f graylog/role.yaml
kubectl apply -n it-monitoring -f graylog/rolebinding.yaml
kubectl apply -n it-monitoring -f elasticsearch/client-svc.yaml
kubectl apply -n it-monitoring -f elasticsearch/master-svc.yaml
kubectl apply -n it-monitoring -f mongodb-replicaset/mongodb-service-client.yaml
kubectl apply -n it-monitoring -f mongodb-replicaset/mongodb-service.yaml
kubectl apply -n it-monitoring -f graylog/headless-service.yaml
kubectl apply -n it-monitoring -f graylog/master-service.yaml
kubectl apply -n it-monitoring -f graylog/udp-service.yaml
kubectl apply -n it-monitoring -f graylog/web-service.yaml
kubectl apply -n it-monitoring -f elasticsearch/client-deployment.yaml
kubectl apply -n it-monitoring -f elasticsearch/data-statefulset.yaml
kubectl apply -n it-monitoring -f elasticsearch/master-statefulset.yaml
kubectl apply -n it-monitoring -f mongodb-replicaset/mongodb-statefulset.yaml
kubectl apply -n it-monitoring -f graylog/statefulset.yaml
kubectl apply -n it-monitoring -f graylog/ingress.yaml
