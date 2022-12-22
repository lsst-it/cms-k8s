#!/usr/bin/env bash
set -xe
USER=hreinking_b

kubectl create ns yagan-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
ssh ${USER}@yagan01.cp.lsst.org 'sudo cat /etc/kubernetes/ssl/kube-ca.pem' > ca.crt
ssh ${USER}@yagan01.cp.lsst.org 'sudo cat /etc/kubernetes/ssl/kube-ca-key.pem' > ca.key
# Recommend using cfssl https://github.com/cloudflare/cfssl
cfssl gencert -ca ca.crt -ca-key ca.key etcd-client.json | cfssljson -bare etcd-client
kubectl appy -f etcd-certs.yaml
helm install yagan-prom -n yagan-prom prometheus-community/kube-prometheus-stack -f values.yaml