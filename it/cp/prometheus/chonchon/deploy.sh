#!/usr/bin/env bash
set -xe

kubectl create ns chonchon-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install chonchon-prom -n chonchon-prom prometheus-community/kube-prometheus-stack -f values.yaml