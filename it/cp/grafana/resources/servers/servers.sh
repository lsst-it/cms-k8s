#!/usr/bin/env bash
set -xuo pipefail

SERVER='yepun01.cp.lsst.org'
ID=$(cat ../ID/servers)
SSH_USER='hreinking_b'
URL="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get ingress grafana -ojson | jq -r '.spec.tls[0].hosts[0]'')"
USER="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-user"]' | base64 --decode)"
PASSWORD="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-password"]' | base64 --decode)"
POD="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl get -n it-grafana pods -o json ' | jq -r '.items[].metadata.name')"

if [ ! -d "list" ] 
then
    mkdir list
fi

sed "s/\"folderId\": 3/\"folderId\": $ID/g" default/server_template.json > list/server_dashboard.json

ssh $SSH_USER@$SERVER "/usr/bin/kubectl wait --for=condition=ready pod -n it-grafana ${POD} > /dev/null 2>&1"
/usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @list/server_dashboard.json > /dev/null 2>&1
