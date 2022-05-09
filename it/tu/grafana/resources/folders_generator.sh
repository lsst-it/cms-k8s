#!/usr/bin/env bash
set -xuo pipefail

SERVER='pillan01.tu.lsst.org'
SSH_USER='hreinking_b'
URL="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get ingress grafana -ojson | jq -r '.spec.tls[0].hosts[0]'')"
USER="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-user"]' | base64 --decode)"
PASSWORD="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-password"]' | base64 --decode)"
POD="$(ssh $SSH_USER@$SERVER '/usr/bin/kubectl get -n it-grafana pods -o json ' | jq -r '.items[].metadata.name')"
Folders=(clusters servers services Kubernetes-Monitoring)
counter=0
if [ ! -d "ID" ] 
then
    mkdir ID
fi
ssh $SSH_USER@$SERVER "/usr/bin/kubectl wait --for=condition=ready pod -n it-grafana ${POD} > /dev/null 2>&1"
for folder in "${Folders[@]}"; do
  /usr/bin/curl -s -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/folders -d "{\"id\":\"$counter\",\"title\":\"$folder\"}" > /dev/null 2>&1
  read -r NAME NUMBER < <(/usr/bin/curl -s -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X GET https://${URL}/api/folders | jq -r '.[] | "\(.title) \(.id)"' | grep $folder)
  echo $NUMBER > ID/$NAME
  counter=$((counter+1))
done
