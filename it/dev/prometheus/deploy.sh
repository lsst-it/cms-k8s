#!/usr/bin/env bash
set -xe

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install bdc-prometheus -n bdc-probetheus prometheus-community/kube-prometheus-stack -f values.yaml