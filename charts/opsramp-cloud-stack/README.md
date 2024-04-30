# OpenTelemetry Collector Helm Charts

## Prerequisites

- Kubernetes
- Helm 3 or above
- Cert Manager

## Verify your setup

### Verify connection to cluster

Execute the below command and make sure you don't get any errors. In case of errors, it is implied that connection to
the cluster is not possible

```bash
 kubectl cluster-info
```

### Verify Helm Version

The output of the below command should be 3 or above

```bash
 helm version
```

## Adding necessary Helm Repos

```bash
# Cert Manager Helm Repo
helm repo add jetstack https://charts.jetstack.io --force-update
# OpenTelemetry Operator Helm Repo
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
# Prometheus Helm Repo (kube-state & node-exporter)
helm repo add prometheus https://prometheus-community.github.io/helm-charts

# Updating Repos
helm repo update
```

## Installing Cert Manager (Prerequisite)

```bash
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.14.4 \
  --set installCRDs=true
```

## Installing OpsRamp Cloud Stack Helm

### Download and extract Helm Chart

```bash
helm pull oci://us-docker.pkg.dev/opsramp-registry/agent-images/opsramp-cloud-stack/opsramp-cloud-stack \
    --version 0.1.0 \
    --untar
cd opsramp-cloud-stack
```

### Install

> [!IMPORTANT]  
> The token given below is based on the feature flag of logs, traces, and metrics. So when any of these features are
> enabled or disabled, the helm chart must be re-deployed with the latest token given below

```bash
helm upgrade -i \
  opsramp-cloud-stack . \
  --namespace opsramp \
  --create-namespace \
  --wait=true \
  --set global.Token="<token>"
```

> [!NOTE]
> * Installation commands must be performed in the directory where the Chart is extracted
> * The same command can be used for both installation and upgrade of the chart (while upgrading the latest chart must
    be downloaded and extracted)
> * We install metrics, logs, traces, and kube-events collector by default. Anything that needs to be disabled must be
    taken care by specifying the flags shown in the **Disabling Components** section

### Check your installation

#### Check if helm chart is installed

```bash
 helm list -n opsramp
```

#### Check if all collector CRs are configured

```bash
kubectl get OpenTelemetryCollector -n opsramp
```

#### Check if all collector services are configured

```bash
kubectl get svc -n opsramp
```

#### Check if all the pods are running

```bash
kubectl get pods -n opsramp
```

> [!NOTE]  
> The pods for the collector might take some time to schedule in the specified namespace

### Disabling Components

#### Disable Metrics Collection

```bash
helm upgrade -i \
  opsramp-cloud-stack . \
  --namespace opsramp \
  --create-namespace \
  --set global.Token="<token>" \
  --wait=true \
  --set metricsCollector.enabled=false
```

#### Disable Logs Collection

```bash
helm upgrade -i \
  opsramp-cloud-stack . \
  --namespace opsramp \
  --create-namespace \
  --set global.Token="<token>" \
  --wait=true \
  --set logsCollector.enabled=false
```

#### Disable Trace Collection

```bash
helm upgrade -i \
  opsramp-cloud-stack . \
  --namespace opsramp \
  --create-namespace \
  --set global.Token="<token>" \
  --wait=true \
  --set tracesCollector.enabled=false
```

#### Disable Kube Events Collection

```bash
helm upgrade -i \
  opsramp-cloud-stack . \
  --namespace opsramp \
  --create-namespace \
  --set global.Token="<token>" \
  --wait=true \
  --set kubeEventsCollector.enabled=false
```

#### Disable Optional Components Installation

kube-state-metrics and Prometheus Node Exporter are installed by default for collection of additional metrics in the
cluster. However, these can be disabled using the command below

```bash
helm upgrade -i \
  opsramp-cloud-stack . \
  --namespace opsramp \
  --create-namespace \
  --set global.Token="<token>" \
  --wait=true \
  --set kubeStateMetrics.enabled=false \
  --set nodeExporter.enabled=false
```

## Uninstalling OpsRamp Cloud Stack

```bash
helm uninstall opsramp-cloud-stack -n opsramp
```

### The OpenTelemetry Collector CRD created by this chart won't be removed by default and should be manually deleted:

```bash 
kubectl delete crd opentelemetrycollectors.opentelemetry.io
kubectl delete crd opampbridges.opentelemetry.io
kubectl delete crd instrumentations.opentelemetry.io
```


