#!/usr/bin/env bash
set -xe

kubectl create ns yagan-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install yagan-prom -n yagan-prom prometheus-community/kube-prometheus-stack -f values.yaml