#!/usr/bin/env bash
kubectl create ns graylog
kubectl apply -n graylog -f elasticsearch/pdb.yaml
kubectl apply -n graylog -f mongodb/svc_account.yaml
kubectl apply -n graylog -f graylog/svc_account.yaml
kubectl apply -n graylog -f graylog/secret.yaml
kubectl apply -n graylog -f mongodb/configmap.yaml
kubectl apply -n graylog -f graylog/configmap.yaml
kubectl apply -n graylog -f graylog/role.yaml
kubectl apply -n graylog -f graylog/rolebinding.yaml
kubectl apply -n graylog -f elasticsearch/svc.yaml
kubectl apply -n graylog -f elasticsearch/svc-headless.yaml
kubectl apply -n graylog -f mongodb/svc-arbiter.yaml
kubectl apply -n graylog -f mongodb/svc-headless.yaml
kubectl apply -n graylog -f graylog/svc.yaml
kubectl apply -n graylog -f graylog/svc-master.yaml
kubectl apply -n graylog -f graylog/svc-udp.yaml
kubectl apply -n graylog -f graylog/svc-web.yaml
kubectl apply -n graylog -f elasticsearch/statefulset.yaml
kubectl apply -n graylog -f mongodb/statefulset-arbiter.yaml
kubectl apply -n graylog -f mongodb/statefulset.yaml
kubectl apply -n graylog -f graylog/statefulset.yaml
kubectl apply -n graylog -f graylog/ingress.yaml
