#!/usr/bin/env bash
helm repo add fluent https://fluent.github.io/helm-charts
helm template it-fluentbit fluent/fluent-bit --namespace it-fluentbit -f values.yaml > template.yaml
