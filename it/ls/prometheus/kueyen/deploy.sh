#!/usr/bin/env bash
set -xe

kubectl create ns kueyen-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install kueyen-prom -n kueyen-prom prometheus-community/kube-prometheus-stack -f values.yaml