#!/usr/bin/env bash
set -xe

kubectl create ns antu-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install antu-prom -n antu-prom prometheus-community/kube-prometheus-stack -f values.yaml