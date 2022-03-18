#!/usr/bin/env bash
set -xuo pipefail

ID=$(cat ../ID/k8s-chonchon)
SERVER='yepun01.cp.lsst.org'
SSH_USER='hreinking_b'
URL="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get ingress grafana -ojson | jq -r '.spec.tls[0].hosts[0]'')"
USER="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-user"]' | base64 --decode)"
PASSWORD="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-password"]' | base64 --decode)"
POD="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl get -n it-grafana pods -o json ' | jq -r '.items[].metadata.name')"

if [ ! -d "list" ] 
then
    mkdir list
fi
cd default
for filename in *.json; do
    sed "s/\"folderId\": 6/\"folderId\": $ID/g" $filename > ../list/$filename
done

ssh $SSH_USER@$SERVER "/usr/bin/kubectl wait --for=condition=ready pod -n it-grafana ${POD} > /dev/null 2>&1"

cd ../list
for filename in *.json; do
    /usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @"$filename" > /dev/null 2>&1
done