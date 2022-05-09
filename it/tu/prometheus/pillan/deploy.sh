#!/usr/bin/env bash
set -xe

kubectl create ns pillan-prom
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install pillan-prom -n pillan-prom prometheus-community/kube-prometheus-stack -f values.yaml