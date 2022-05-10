#!/usr/bin/env bash
set -xe

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install pillan-prom -n it-monitoring prometheus-community/kube-prometheus-stack -f values.yaml
