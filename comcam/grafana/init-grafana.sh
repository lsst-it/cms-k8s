#!/usr/bin/env bash
set -xuo pipefail

NAMESPACE='comcam-grafana'
URL="$(kubectl -n ${NAMESPACE} get ingress grafana -ojson | jq -r '.spec.tls[0].hosts[0]')"
USER="$(kubectl -n ${NAMESPACE} get secret grafana-credentials -ojson | jq -r '.data["admin-user"]' | base64 --decode)"
PASSWORD="$(kubectl -n ${NAMESPACE} get secret grafana-credentials -ojson | jq -r '.data["admin-password"]' | base64 --decode)"

/usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @'resources/CCS-Traffic.json'
/usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @'resources/CCS-Database.json'