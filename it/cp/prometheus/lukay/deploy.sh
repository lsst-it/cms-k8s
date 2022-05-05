#!/usr/bin/env bash
set -xe

kubectl create ns lukay-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install lukay-prom -n lukay-prom prometheus-community/kube-prometheus-stack -f values.yaml