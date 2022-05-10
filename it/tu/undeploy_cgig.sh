#!/usr/bin/env bash
set -ex
#  Undeploy Graylog
kubectl delete  -n it-monitoring -f graylog-stack/graylog/ingress.yaml
kubectl delete  -n it-monitoring -f graylog-stack/graylog/statefulset.yaml
kubectl delete  -n it-monitoring -f graylog-stack/mongodb-replicaset/mongodb-statefulset.yaml
kubectl delete  -n it-monitoring -f graylog-stack/elasticsearch/master-statefulset.yaml
kubectl delete  -n it-monitoring -f graylog-stack/elasticsearch/data-statefulset.yaml
kubectl delete  -n it-monitoring -f graylog-stack/elasticsearch/client-deployment.yaml
kubectl delete  -n it-monitoring -f graylog-stack/graylog/web-service.yaml
kubectl delete  -n it-monitoring -f graylog-stack/graylog/udp-service.yaml
kubectl delete  -n it-monitoring -f graylog-stack/graylog/master-service.yaml
kubectl delete  -n it-monitoring -f graylog-stack/graylog/headless-service.yaml
kubectl delete  -n it-monitoring -f graylog-stack/mongodb-replicaset/mongodb-service.yaml
kubectl delete  -n it-monitoring -f graylog-stack/mongodb-replicaset/mongodb-service-client.yaml
kubectl delete  -n it-monitoring -f graylog-stack/elasticsearch/master-svc.yaml
kubectl delete  -n it-monitoring -f graylog-stack/elasticsearch/client-svc.yaml
kubectl delete  -n it-monitoring -f graylog-stack/graylog/rolebinding.yaml
kubectl delete  -n it-monitoring -f graylog-stack/graylog/role.yaml
kubectl delete  -n it-monitoring -f graylog-stack/graylog/serviceaccount.yaml
kubectl delete  -n it-monitoring -f graylog-stack/elasticsearch/master-serviceaccount.yaml
kubectl delete  -n it-monitoring -f graylog-stack/elasticsearch/data-serviceaccount.yaml
kubectl delete  -n it-monitoring -f graylog-stack/elasticsearch/client-serviceaccount.yaml
kubectl delete  -n it-monitoring -f graylog-stack/graylog/configmap.yaml
kubectl delete  -n it-monitoring -f graylog-stack/mongodb-replicaset/mongodb-mongodb-configmap.yaml
kubectl delete  -n it-monitoring -f graylog-stack/mongodb-replicaset/mongodb-init-configmap.yaml
kubectl delete  -n it-monitoring -f graylog-stack/elasticsearch/configmap.yaml
kubectl delete  -n it-monitoring -f graylog-stack/graylog/secret.yaml
#  Undeploy kube-prometheus and alertmanager
helm delete pillan-prom -n pillan-prom prometheus-community/kube-prometheus-stack
#  Undeploy Grafana
kubectl delete -n it-monitoring -f grafana/ingress.yaml
kubectl delete -n it-monitoring -f grafana/deployment.yaml
kubectl delete -n it-monitoring -f grafana/service.yaml
kubectl delete -n it-monitoring -f grafana/role-binding.yaml
kubectl delete -n it-monitoring -f grafana/role.yaml
kubectl delete -n it-monitoring -f grafana/cluster-role-binding.yaml
kubectl delete -n it-monitoring -f grafana/cluster-role.yaml
kubectl delete -n it-monitoring -f grafana/configmap.yaml
kubectl delete -n it-monitoring -f grafana/svc-account.yaml
kubectl delete -n it-monitoring -f grafana/pod-security-policy.yaml
kubectl delete -n it-monitoring -f grafana/ldap-secret.yaml
kubectl delete -n it-monitoring -f grafana/grafana-credentials.yaml
kubectl delete -n it-monitoring -f grafana/influxdb-credentials.yaml
#  Undeploy InfluxDB
kubectl delete -n it-monitoring -f influxdb/job.yaml
kubectl delete -n it-monitoring -f influxdb/ingress.yaml
kubectl delete -n it-monitoring -f influxdb/statefulset.yaml
kubectl delete -n it-monitoring -f influxdb/service.yaml
kubectl delete -n it-monitoring -f influxdb/configmap.yaml
kubectl delete -n it-monitoring -f influxdb/svc-account.yaml
kubectl delete -n it-monitoring -f influxdb/influxdb-credentials.yaml
#  Undeploy Cert-Manager Issuer
kubectl delete -f cert-manager/letsencrypt-staging.yaml
kubectl delete -f cert-manager/letsencrypt.yaml
kubectl delete -f cert-manager/secret.yaml
helm delete cert-manager jetstack/cert-manager -n it-monitoring
#  Delete Namespace
kubectl delete ns it-monitoring

