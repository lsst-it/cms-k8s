#!/usr/bin/env bash
set -xe

kubectl create ns ruka-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install ruka-prom -n ruka-prom prometheus-community/kube-prometheus-stack -f values.yaml