#!/usr/bin/env bash
set -xe

kubectl create ns gaw-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install gaw-prom -n gaw-prom prometheus-community/kube-prometheus-stack -f values.yaml