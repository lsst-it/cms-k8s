#!/usr/bin/env bash
set -xe

kubectl create ns prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus -n prometheus prometheus-community/kube-prometheus-stack -f values.yaml