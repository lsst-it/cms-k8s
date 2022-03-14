#!/usr/bin/env bash
set -xuo pipefail

SERVER='ruka01.dev.lsst.org'
ROOT_PATH=$(pwd)
URL="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl -n it-grafana get ingress grafana -ojson | jq -r '.spec.tls[0].hosts[0]'')"
USER="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-user"]' | base64 --decode)"
PASSWORD="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-password"]' | base64 --decode)"
POD="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl get -n it-grafana pods -o json ' | jq -r '.items[].metadata.name')"
Folders=(clusters servers services k8s-ruka)
SSH_USER="hreinking_b"
counter=0
# Folders Creation
if [ ! -d "ID" ] 
then
    mkdir ID
fi

ssh $SSH_USER@$SERVER "/usr/bin/kubectl wait --for=condition=ready pod -n it-grafana ${POD} > /dev/null 2>&1"

for folder in "${Folders[@]}"; do
  /usr/bin/curl -s -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/folders -d "{\"id\":\"$counter\",\"title\":\"$folder\"}" > /dev/null 2>&1
  /usr/bin/curl -s -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X GET https://${URL}/api/folders | jq ".[$counter].id" > ID/$folder
  counter=$((counter+1))
done

#Clusters
CLUSTER_ID=$(cat $ROOT_PATH/ID/clusters)
cd clusters
if [ ! -d "list" ] 
then
    mkdir list
fi
cd default
for filename in *.json; do
    sed "s/\"folderId\": 4/\"folderId\": $CLUSTER_ID/g" $filename > ../list/$filename
done

cd ../list
for filename in *.json; do
    /usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @"$filename" > /dev/null 2>&1
done

#Services
SERVICES_ID=$(cat $ROOT_PATH/ID/services)
cd ../../services
if [ ! -d "list" ] 
then
    mkdir list
fi
cd default
for filename in *.json; do
    sed "s/\"folderId\": 5/\"folderId\": $SERVICES_ID/g" $filename > ../list/$filename
done

cd ../list
for filename in *.json; do
    /usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @"$filename" > /dev/null 2>&1
done

#Servers
SERVERS_ID=$(cat $ROOT_PATH/ID/servers)
cd ../../servers
ssh -l $SSH_USER foreman.ls.lsst.org 'sudo /usr/bin/hammer host list --fields Name | grep lsst.org' > server_list.txt
ssh -l $SSH_USER foreman.dev.lsst.org 'sudo /usr/bin/hammer host list --fields Name | grep lsst.org' >> server_list.txt
ssh -l $SSH_USER foreman.tuc.lsst.cloud 'sudo /usr/bin/hammer host list --fields Name | grep lsst.org' >> server_list.txt

if [ ! -d "list" ] 
then
    mkdir list
fi
while read server;
do 
  sed "s/SERVER_NAME/$server/g" server_template.json > default/$server.json
  sed "s/\"folderId\": 3/\"folderId\": $SERVERS_ID/g" default/$server.json > list/$server.json
done < server_list.txt

for filename in list/*.json; do
    /usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @"$filename" > /dev/null 2>&1
done

#Ruka K8s metrics
cd ../../k8s-ruka
if [ ! -d "list" ] 
then
    mkdir list
fi
cd default
for filename in *.json; do
    sed "s/\"folderId\": 6/\"folderId\": $ID/g" $filename > ../list/$filename
done

cd ../list
for filename in *.json; do
    /usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @"$filename" > /dev/null 2>&1
done
