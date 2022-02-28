#!/usr/bin/env bash
set -xuo pipefail

SERVER='luan01.ls.lsst.org'
URL="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl -n it-grafana get ingress grafana -ojson | jq -r '.spec.tls[0].hosts[0]'')"
USER="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-user"]' | base64 --decode)"
PASSWORD="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-password"]' | base64 --decode)"
POD="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl get -n it-grafana pods -o json ' | jq -r '.items[].metadata.name')"
Folders=(clusters servers services)
counter=0
if [ ! -d "ID" ] 
then
    mkdir ID
fi
ssh hreinking_b@$SERVER "/usr/bin/kubectl wait --for=condition=ready pod -n it-grafana ${POD} > /dev/null 2>&1"
for folder in "${Folders[@]}"; do
  /usr/bin/curl -s -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/folders -d "{\"id\":\"$counter\",\"title\":\"$folder\"}" > /dev/null 2>&1
  /usr/bin/curl -s -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X GET https://${URL}/api/folders | jq ".[$counter].id" > ID/$folder
  counter=$((counter+1))
done