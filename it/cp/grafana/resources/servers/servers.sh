#!/usr/bin/env bash
set -xuo pipefail

SERVER='yepun01.cp.lsst.org'
ID=$(cat ../ID/servers)
SSH_USER='hreinking_b'
URL="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get ingress grafana -ojson | jq -r '.spec.tls[0].hosts[0]'')"
USER="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-user"]' | base64 --decode)"
PASSWORD="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-password"]' | base64 --decode)"
POD="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl get -n it-grafana pods -o json ' | jq -r '.items[].metadata.name')"

ssh -l $SSH_USER foreman.ls.lsst.org 'sudo /usr/bin/hammer host list --fields Name | grep lsst.org' > server_list.txt
ssh -l $SSH_USER foreman.cp.lsst.org 'sudo /usr/bin/hammer host list --fields Name | grep lsst.org' >> server_list.txt
ssh -l $SSH_USER foreman.dev.lsst.org 'sudo /usr/bin/hammer host list --fields Name | grep lsst.org' >> server_list.txt
ssh -l $SSH_USER foreman.tuc.lsst.org 'sudo /usr/bin/hammer host list --fields Name | grep lsst.org' >> server_list.txt

if [ ! -d "list" ] 
then
    mkdir list
fi
while read server;
do 
  sed "s/SERVER_NAME/$server/g" server_template.json > default/$server.json
  sed "s/\"folderId\": 3/\"folderId\": $ID/g" default/$server.json > list/$server.json
done < server_list.txt


ssh $SSH_USER@$SERVER "/usr/bin/kubectl wait --for=condition=ready pod -n it-grafana ${POD} > /dev/null 2>&1"
for filename in list/*.json; do
    /usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @"$filename" > /dev/null 2>&1
done