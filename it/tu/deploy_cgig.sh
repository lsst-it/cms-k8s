#!/usr/bin/env bash
set -ex
#  Create Namespace
kubectl create ns it-monitoring
#  Deploy Cert-Manager Issuer
kubectl apply -n it-monitoring -f cert-manager/secret.yaml
kubectl apply -n it-monitoring -f cert-manager/letsencrypt.yaml
kubectl apply -n it-monitoring -f cert-manager/letsencrypt-staging.yaml
kubectl wait --for=condition=ready --timeout=180s -n it-monitoring issuer/letsencrypt
kubectl wait --for=condition=ready --timeout=180s -n it-monitoring issuer/letsencrypt-staging
#  Deploy InfluxDB
kubectl apply -n it-monitoring -f influxdb/svc-account.yaml
kubectl apply -n it-monitoring -f influxdb/configmap.yaml
kubectl apply -n it-monitoring -f influxdb/service.yaml
kubectl apply -n it-monitoring -f influxdb/statefulset.yaml
kubectl apply -n it-monitoring -f influxdb/ingress.yaml
kubectl apply -n it-monitoring -f influxdb/job.yaml
kubectl expose service -n it-monitoring influxdb --type=LoadBalancer --name=influx
#  Deploy Grafana
kubectl apply -n it-monitoring -f grafana/influxdb-credentials.yaml
kubectl apply -n it-monitoring -f grafana/grafana-credentials.yaml
kubectl apply -n it-monitoring -f grafana/ldap-secret.yaml
kubectl apply -n it-monitoring -f grafana/pod-security-policy.yaml
kubectl apply -n it-monitoring -f grafana/svc-account.yaml
kubectl apply -n it-monitoring -f grafana/configmap.yaml
kubectl apply -n it-monitoring -f grafana/cluster-role.yaml
kubectl apply -n it-monitoring -f grafana/cluster-role-binding.yaml
kubectl apply -n it-monitoring -f grafana/role.yaml
kubectl apply -n it-monitoring -f grafana/role-binding.yaml
kubectl apply -n it-monitoring -f grafana/service.yaml
kubectl apply -n it-monitoring -f grafana/deployment.yaml
kubectl apply -n it-monitoring -f grafana/ingress.yaml
#  Deploy kube-prometheus and alertmanager
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install pillan-prom -n pillan-prom prometheus-community/kube-prometheus-stack -f prometheus/pillan/values.yaml
#  Deploy Graylog
kubectl apply  -n it-monitoring -f graylog-stack/graylog/secret.yaml
kubectl apply  -n it-monitoring -f graylog-stack/elasticsearch/configmap.yaml
kubectl apply  -n it-monitoring -f graylog-stack/mongodb-replicaset/mongodb-init-configmap.yaml
kubectl apply  -n it-monitoring -f graylog-stack/mongodb-replicaset/mongodb-mongodb-configmap.yaml
kubectl apply  -n it-monitoring -f graylog-stack/graylog/configmap.yaml
kubectl apply  -n it-monitoring -f graylog-stack/elasticsearch/client-serviceaccount.yaml
kubectl apply  -n it-monitoring -f graylog-stack/elasticsearch/data-serviceaccount.yaml
kubectl apply  -n it-monitoring -f graylog-stack/elasticsearch/master-serviceaccount.yaml
kubectl apply  -n it-monitoring -f graylog-stack/graylog/serviceaccount.yaml
kubectl apply  -n it-monitoring -f graylog-stack/graylog/role.yaml
kubectl apply  -n it-monitoring -f graylog-stack/graylog/rolebinding.yaml
kubectl apply  -n it-monitoring -f graylog-stack/elasticsearch/client-svc.yaml
kubectl apply  -n it-monitoring -f graylog-stack/elasticsearch/master-svc.yaml
kubectl apply  -n it-monitoring -f graylog-stack/mongodb-replicaset/mongodb-service-client.yaml
kubectl apply  -n it-monitoring -f graylog-stack/mongodb-replicaset/mongodb-service.yaml
kubectl apply  -n it-monitoring -f graylog-stack/graylog/headless-service.yaml
kubectl apply  -n it-monitoring -f graylog-stack/graylog/master-service.yaml
kubectl apply  -n it-monitoring -f graylog-stack/graylog/udp-service.yaml
kubectl apply  -n it-monitoring -f graylog-stack/graylog/web-service.yaml
kubectl apply  -n it-monitoring -f graylog-stack/elasticsearch/client-deployment.yaml
kubectl apply  -n it-monitoring -f graylog-stack/elasticsearch/data-statefulset.yaml
kubectl apply  -n it-monitoring -f graylog-stack/elasticsearch/master-statefulset.yaml
kubectl apply  -n it-monitoring -f graylog-stack/mongodb-replicaset/mongodb-statefulset.yaml
kubectl apply  -n it-monitoring -f graylog-stack/graylog/statefulset.yaml
kubectl apply  -n it-monitoring -f graylog-stack/graylog/ingress.yaml
