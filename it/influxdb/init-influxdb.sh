#!/usr/bin/env bash
set -xuo pipefail

INFLUXDB_NAMESPACE='it-influxdb'
INFLUXDB_USER='telegraf'
GRAFANA_NAMESPACE='it-grafana'
DATABASE='telegraf'

INFLUXDB_HOST="$(kubectl -n ${INFLUXDB_NAMESPACE} get ingress influxdb -ojson | jq -r '.spec.tls[0].hosts[0]')"
INFLUXDB_PASSWORD="$(kubectl -n ${INFLUXDB_NAMESPACE} get secret influxdb-credentials -ojson | jq -r '.data["influxdb-password"]' | base64 --decode)"
GRAFANA_PASSWORD="$(kubectl -n ${GRAFANA_NAMESPACE} get secret grafana-credentials -ojson | jq -r '.data["admin-password"]' | base64 --decode)"

kubectl exec -it -n ${INFLUXDB_NAMESPACE} influxdb-0 -- \
    /usr/bin/influx -host "${INFLUXDB_HOST}" -port 443 -ssl -username "${INFLUXDB_USER}" -password  "${INFLUXDB_PASSWORD}" -execute "CREATE DATABASE ${DATABASE}"
kubectl exec -it -n ${INFLUXDB_NAMESPACE} influxdb-0 -- \
    /usr/bin/influx -host "${INFLUXDB_HOST}" -port 443 -ssl -username "${INFLUXDB_USER}" -password  "${INFLUXDB_PASSWORD}" -execute "USE DATABASE ${DATABASE;} CREATE USER telegraf WITH PASSWORD ${GRAFANA_PASSWORD} WITH ALL PRIVILEGES"