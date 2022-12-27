#!/usr/bin/env bash
set -xuo pipefail

SSH_USER='hreinking_b'
SERVER='luan01.ls.lsst.org'
URL="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get ingress grafana -ojson | jq -r '.spec.tls[0].hosts[0]'')"
USER="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-user"]' | base64 --decode)"
PASSWORD="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-password"]' | base64 --decode)"

/usr/bin/kubectl wait --for=condition=ready pod -n ${NAMESPACE} ${POD} > /dev/null 2>&1

sed "s/\"folderId\": 3/\"folderId\": $NETWORK_ID/g" default/CR-BR-DS-Bandwidth.json > list/CR-BR-DS-Bandwidth.json

for filename in list/*.json; do
    /usr/bin/curl -k -u $USER:$PASSWORD -H "Content-Type: application/json" -X POST https://$URL/api/dashboards/db -d @"$filename" > /dev/null 2>&1
done
