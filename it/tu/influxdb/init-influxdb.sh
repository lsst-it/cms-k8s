#!/usr/bin/env bash
set -xuo pipefail

INFLUXDB_USER='telegraf'
NAMESPACE='it-monitoring'
DATABASE='telegraf'

INFLUXDB_HOST="$(kubectl -n ${NAMESPACE} get ingress influxdb -ojson | jq -r '.spec.tls[0].hosts[0]')"
INFLUXDB_PASSWORD="$(kubectl -n ${NAMESPACE} get secret influxdb-credentials -ojson | jq -r '.data["influxdb-password"]' | base64 --decode)"
GRAFANA_PASSWORD=\'"$(kubectl -n ${NAMESPACE} get secret grafana-credentials -ojson | jq -r '.data["admin-password"]' | base64 --decode)"\'

kubectl exec -it -n $NAMESPACE influxdb-0 -- \
    /usr/bin/influx -username $INFLUXDB_USER -password $INFLUXDB_PASSWORD -execute "CREATE DATABASE ${DATABASE}"
kubectl exec -it -n ${NAMESPACE} influxdb-0 -- \
    /usr/bin/influx -host "${INFLUXDB_HOST}" -port 443 -ssl -username "${INFLUXDB_USER}" -password  "${INFLUXDB_PASSWORD}" -execute "USE DATABASE ${DATABASE}; CREATE USER telegraf WITH PASSWORD ${GRAFANA_PASSWORD} WITH ALL PRIVILEGES"