#!/usr/bin/env bash
set -xe

kubectl create ns yepun-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install yepun-prom -n yepun-prom prometheus-community/kube-prometheus-stack -f values.yaml