
# KeyValue Helm Chart 
<img align="left" width="120" height="100" src="https://keyvalue.systems/images/kv-logo.png" alt="KeyValue Logo">


![Version: 0.0.3](https://img.shields.io/badge/Version-0.0.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A generic helm chart for backend services in Kubernetes. It allows you to manage services with multi-resource with ease.
For more on helm, refer [Helm Documentation](https://helm.sh/docs/).


## Installing the Chart;

```bash
$ helm repo add <REPO-NAME> <CHART-REPO-URL>

$ helm install [RELEASE_NAME] <REPO-NAME>/kv-service --namespace ${K8S_NAMESPACE}
```
## Upgrading the Chart;

```bash
$ helm repo add <REPO-NAME> <CHART-REPO-URL>
$ helm repo update
$ helm upgrade  [RELEASE_NAME] <REPO-NAME>/kv-service --namespace ${K8S_NAMESPACE}
```

## Uninstalling the Chart

To uninstall/delete the release :

```bash
helm delete [RELEASE_NAME]
```

## Prerequisites

* Kubernetes 1.16+
* External Secrets operator
* Helm v3.6+

#
## Configurations
The following table lists the configurable parameters of the `KV-helm-chart` chart and their default values.

```yml
serviceName: my-service

base: 
  ...
deployment:
  ...
jobs:
  ...
cronjobs:
  ...
``` 
          