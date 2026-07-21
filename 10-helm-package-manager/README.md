# Step 10: Helm Package Manager

## What is Helm?

Helm is the package manager for Kubernetes. It helps you define, install, and upgrade Kubernetes applications.

## Key Concepts

### Chart
A Helm Chart is a package of pre-configured Kubernetes resources. Think of it as a Kubernetes application blueprint.

### Repository
A collection of charts that can be shared and downloaded.

### Release
A running instance of a chart with a specific configuration.

### Values
Configuration that customizes a chart.

## Helm Architecture

```
┌─────────────────────────────────────────────────┐
│                   Helm Client                    │
│  ┌─────────┐  ┌─────────┐  ┌──────────────┐   │
│  │  Chart   │  │ Values  │  │   Release    │   │
│  │         │  │         │  │   Config     │   │
│  └────┬────┘  └────┬────┘  └──────┬───────┘   │
│       │            │              │            │
│       └────────────┴──────────────┘            │
│                    │                           │
│                    ▼                           │
│  ┌─────────────────────────────────────────┐   │
│  │         Helm Template Engine            │   │
│  └─────────────────────────────────────────┘   │
│                    │                           │
│                    ▼                           │
│  ┌─────────────────────────────────────────┐   │
│  │      Kubernetes Manifests (YAML)        │   │
│  └─────────────────────────────────────────┘   │
└─────────────────────────────────────────────────┘
```

## Helm Chart Structure

```
mychart/
├── Chart.yaml          # Chart metadata
├── values.yaml         # Default values
├── charts/             # Dependencies
├── templates/          # Template files
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── configmap.yaml
│   └── _helpers.tpl
└── README.md
```

## Template Syntax

```yaml
# values.yaml
replicaCount: 3
image:
  repository: nginx
  tag: "1.21"
service:
  type: ClusterIP
  port: 80
```

```yaml
# templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "mychart.fullname" . }}
spec:
  replicas: {{ .Values.replicaCount }}
  template:
    spec:
      containers:
      - name: {{ .Chart.Name }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
```

## Common Commands

```bash
# Search for charts
helm search repo nginx

# Install a chart
helm install my-release bitnami/nginx

# List releases
helm list

# Upgrade a release
helm upgrade my-release bitnami/nginx --set replicaCount=5

# Rollback a release
helm rollback my-release 1

# Uninstall a release
helm uninstall my-release

# Create a new chart
helm create mychart

# Package a chart
helm package mychart

# Lint a chart
helm lint mychart
```

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
