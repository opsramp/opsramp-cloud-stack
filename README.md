# OpenTelemetry Collector Helm Charts

This repository consists of Helm Charts for OpenTelemetry Collector meant to ship data to OpsRamp.

## Prerequisites

- Kubernetes
- Helm

## Adding necessary Helm Repos

```bash
helm repo add jetstack https://charts.jetstack.io --force-update
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo add prometheus https://prometheus-community.github.io/helm-charts
helm repo update
```

## Installing Cert Manager

```bash
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.14.4 \
  --set installCRDs=true
```

