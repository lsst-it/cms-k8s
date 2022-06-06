#!/usr/bin/env bash
kubectl delete -n graylog -f graylog/ingress.yaml
kubectl delete -n graylog -f graylog/statefulset.yaml
kubectl delete -n graylog -f mongodb/statefulset.yaml
kubectl delete -n graylog -f mongodb/statefulset-arbiter.yaml
kubectl delete -n graylog -f elasticsearch/statefulset.yaml
kubectl delete -n graylog -f graylog/svc-web.yaml
kubectl delete -n graylog -f graylog/svc-udp.yaml
kubectl delete -n graylog -f graylog/svc-master.yaml
kubectl delete -n graylog -f graylog/svc.yaml
kubectl delete -n graylog -f mongodb/svc-headless.yaml
kubectl delete -n graylog -f mongodb/svc-arbiter.yaml
kubectl delete -n graylog -f elasticsearch/svc-headless.yaml
kubectl delete -n graylog -f elasticsearch/svc.yaml
kubectl delete -n graylog -f graylog/rolebinding.yaml
kubectl delete -n graylog -f graylog/role.yaml
kubectl delete -n graylog -f graylog/configmap.yaml
kubectl delete -n graylog -f mongodb/configmap.yaml
kubectl delete -n graylog -f graylog/secret.yaml
kubectl delete -n graylog -f graylog/svc_account.yaml
kubectl delete -n graylog -f mongodb/svc_account.yaml
kubectl delete -n graylog -f elasticsearch/pdb.yaml
kubectl delete ns graylog
