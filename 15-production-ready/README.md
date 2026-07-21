# Step 15: Production Ready - Best Practices & Deployment Strategies

## Overview

This final step covers production-ready Kubernetes deployments, including best practices, CI/CD, and advanced deployment strategies.

## Production Checklist

### 1. Resource Management
```yaml
resources:
  requests:
    memory: "256Mi"
    cpu: "250m"
  limits:
    memory: "512Mi"
    cpu: "500m"
```

### 2. Health Probes
```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 15
  periodSeconds: 20
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10
```

### 3. Security Context
```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1000
  readOnlyRootFilesystem: true
  capabilities:
    drop:
    - ALL
```

### 4. Network Policies
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
```

## Deployment Strategies

### 1. Rolling Update (Default)
- Gradually replace pods
- Zero downtime
- Configurable surge and unavailable

### 2. Blue-Green Deployment
```
┌─────────────────────────────────────────────────────────┐
│                  Blue-Green Deployment                   │
│                                                          │
│  ┌─────────────┐           ┌─────────────┐             │
│  │    Blue     │           │    Green    │             │
│  │  (Current)  │           │   (New)     │             │
│  └──────┬──────┘           └──────┬──────┘             │
│         │                         │                     │
│         └────────────┬────────────┘                     │
│                      │                                  │
│              ┌───────┴───────┐                         │
│              │    Service    │                         │
│              └───────────────┘                         │
└─────────────────────────────────────────────────────────┘
```

### 3. Canary Deployment
```
┌─────────────────────────────────────────────────────────┐
│                  Canary Deployment                       │
│                                                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │
│  │   Current   │  │   Current   │  │   Canary    │    │
│  │    (v1)     │  │    (v1)     │  │    (v2)     │    │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘    │
│         │                │                │             │
│         └────────────────┼────────────────┘             │
│                          │                              │
│                  ┌───────┴───────┐                     │
│                  │    Service    │                     │
│                  └───────────────┘                     │
└─────────────────────────────────────────────────────────┘
```

## CI/CD Pipeline

### GitHub Actions Example
```yaml
name: Deploy to Kubernetes
on:
  push:
    branches: [main]
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Build Docker image
      run: docker build -t my-app:${{ github.sha }} .
    
    - name: Push to registry
      run: docker push my-app:${{ github.sha }}
    
    - name: Deploy to Kubernetes
      run: |
        kubectl set image deployment/my-app my-app=my-app:${{ github.sha }}
        kubectl rollout status deployment/my-app
```

## Monitoring & Alerting

### Prometheus + Grafana Stack
```bash
# Install kube-prometheus-stack
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack
```

### Key Metrics to Monitor
- Pod CPU/Memory usage
- Node CPU/Memory/Disk usage
- API server latency
- Pod restart count
- Container OOM kills

## Backup & Disaster Recovery

### etcd Backup
```bash
# Backup etcd
ETCDCTL_API=3 etcdctl snapshot save backup.db

# Restore etcd
ETCDCTL_API=3 etcdctl snapshot restore backup.db
```

### Velero for Backup
```bash
# Install Velero
velero install --provider aws --bucket my-backup

# Backup
velero backup create my-backup

# Restore
velero restore create --from-backup my-backup
```

## Production Checklist

- [ ] Resource requests and limits set
- [ ] Health probes configured
- [ ] Security context applied
- [ ] Network policies defined
- [ ] RBAC configured
- [ ] Secrets properly managed
- [ ] Monitoring and alerting set up
- [ ] Backup strategy in place
- [ ] CI/CD pipeline configured
- [ ] Load testing performed
- [ ] Disaster recovery tested

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
