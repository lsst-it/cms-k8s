#!/usr/bin/env bash
set -xe

kubectl create ns chonchon-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
ssh ${USER}@chonchon01.cp.lsst.org 'sudo cat /etc/kubernetes/ssl/kube-ca.pem' > ca.crt
ssh ${USER}@chonchon01.cp.lsst.org 'sudo cat /etc/kubernetes/ssl/kube-ca-key.pem' > ca.key
# Recommend using cfssl https://github.com/cloudflare/cfssl
cfssl gencert -ca ca.crt -ca-key ca.key etcd-client.json | cfssljson -bare etcd-client
kubectl appy -f etcd-certs.yaml
helm install chonchon-prom -n chonchon-prom prometheus-community/kube-prometheus-stack -f values.yaml