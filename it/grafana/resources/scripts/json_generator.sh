#!/usr/bin/env bash

while read server;
do 
  sed "s/SERVER_NAME/$server/g" server_template.json > servers/$server.json
  echo "$server" 
done < server_list.txt