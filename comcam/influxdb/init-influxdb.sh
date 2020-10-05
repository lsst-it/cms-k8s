#!/usr/bin/env bash
set -xuo pipefail

INFLUXDB_NAMESPACE='comcam-influxdb'
GRAFANA_NAMESPACE='comcam-grafana'
DATABASE='grafana'

INFLUXDB_HOST="$(kubectl -n ${INFLUXDB_NAMESPACE} get ingress influxdb -ojson | jq -r '.spec.tls[0].hosts[0]')"
INFLUXDB_USER="$(kubectl -n ${INFLUXDB_NAMESPACE} get secret influxdb-credentials -ojson | jq -r '.data["influxdb-user"]' | base64 --decode)"
INFLUXDB_PASSWORD="$(kubectl -n ${INFLUXDB_NAMESPACE} get secret influxdb-credentials -ojson | jq -r '.data["influxdb-password"]' | base64 --decode)"
GRAFANA_PASSWORD="$(kubectl -n ${GRAFANA_NAMESPACE} get secret grafana-credentials -ojson | jq -r '.data["admin-password"]' | base64 --decode)"
POD="$(kubectl get -n ${INFLUXDB_NAMESPACE} pods -o json | jq -r '.items[].metadata.name')"

/usr/bin/kubectl wait --for=condition=ready pod -n ${INFLUXDB_NAMESPACE} ${POD} > /dev/null 2>&1
kubectl exec -it -n ${INFLUXDB_NAMESPACE} influxdb-0 -- \
    /usr/bin/influx -host "${INFLUXDB_HOST}" -port 443 -ssl -username "${INFLUXDB_USER}" -password  "${INFLUXDB_PASSWORD}" -execute "CREATE DATABASE ${DATABASE}"  > /dev/null 2>&1
kubectl exec -it -n ${INFLUXDB_NAMESPACE} influxdb-0 -- \
    /usr/bin/influx -host "${INFLUXDB_HOST}" -port 443 -ssl -username "${INFLUXDB_USER}" -password  "${INFLUXDB_PASSWORD}" -execute "CREATE USER ${INFLUXDB_USER} WITH PASSWORD '${GRAFANA_PASSWORD}' WITH ALL PRIVILEGES"  > /dev/null 2>&1