#!/usr/bin/env bash
kubectl create ns it-unifi
kubectl apply -f resources/svc.yaml
kubectl apply -f resources/deployment.yaml
kubectl apply -f resources/ingress.yaml
