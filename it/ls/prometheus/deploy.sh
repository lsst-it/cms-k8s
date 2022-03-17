#!/usr/bin/env bash
set -xe

kubectl create ns luan-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus -n luan-prom prometheus-community/kube-prometheus-stack -f values.yaml