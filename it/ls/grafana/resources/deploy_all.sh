#!/usr/bin/env bash
set -xuo pipefail

SERVER='luan01.ls.lsst.org'
ROOT_PATH=$(pwd)
URL="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl -n it-grafana get ingress grafana -ojson | jq -r '.spec.tls[0].hosts[0]'')"
USER="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-user"]' | base64 --decode)"
PASSWORD="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl -n it-grafana get secret grafana-credentials -ojson ' | jq -r '.data["admin-password"]' | base64 --decode)"
POD="$(ssh hreinking_b@$SERVER '/usr/bin/kubectl get -n it-grafana pods -o json ' | jq -r '.items[].metadata.name')"
Folders=(clusters network servers services Kubernetes-Monitoring)
SSH_USER="hreinking_b"
counter=$RANDOM
NUMBER='0'
NAME=null
# Folders Creation
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
declare CLUSTERS_ID="$(cat ID/clusters)"
declare SERVICES_ID="$(cat ID/services)"
declare NETWORK_ID="$(cat ID/network)"
declare SERVERS_ID="$(cat ID/servers)"
declare K8S_MON_ID="$(cat ID/Kubernetes-Monitoring)"

#Clusters
cd clusters
if [ ! -d "list" ] 
then
    mkdir list
fi
cd default
for filename in *.json; do
    sed "s/\"folderId\": 4/\"folderId\": $CLUSTERS_ID/g" $filename > ../list/$filename
done

cd ../list
for filename in *.json; do
    /usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @"$filename" > /dev/null 2>&1
done

#Services
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

#Kubernetes Monitoring
cd ../../Kubernetes-Monitoring
if [ ! -d "list" ] 
then
    mkdir list
fi
cd default
for filename in *.json; do
    sed "s/\"folderId\": 6/\"folderId\": $K8S_MON_ID/g" $filename > ../list/$filename
done

cd ../list
for filename in *.json; do
    /usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @"$filename" > /dev/null 2>&1
done

#Servers
cd ../../servers

if [ ! -d "list" ] 
then
    mkdir list
fi

sed "s/\"folderId\": 3/\"folderId\": $SERVERS_ID/g" default/server_template.json > list/server_dashboard.json

/usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/dashboards/db -d @list/server_dashboard.json > /dev/null 2>&1

#Network
cd ../network

if [ ! -d "list" ] 
then
    mkdir list
fi

cd default
for filename in *.json; do
    sed "s/\"folderId\": 3/\"folderId\": $NETWORK_ID/g" $filename > ../list/$filename
done

cd ../list
for filename in *.json; do
    /usr/bin/curl -k -u $USER:$PASSWORD -H "Content-Type: application/json" -X POST https://$URL/api/dashboards/db -d @"$filename" > /dev/null 2>&1
done