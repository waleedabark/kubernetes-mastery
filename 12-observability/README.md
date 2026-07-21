# Step 12: Observability - Logging, Monitoring & Tracing

## Overview

Observability is the ability to understand what's happening inside your system. In Kubernetes, this includes logging, monitoring, and tracing.

## Three Pillars of Observability

### 1. Logging
- What happened and when
- Container logs, application logs
- Aggregated logging with ELK/EFK stack

### 2. Metrics
- Numerical measurements over time
- CPU, memory, network, custom metrics
- Prometheus + Grafana

### 3. Tracing
- Request flow through services
- Distributed tracing with Jaeger/Zipkin
- Understanding latency and bottlenecks

## Logging

### Container Logs
```bash
# View pod logs
kubectl logs <pod-name>

# View logs with previous container
kubectl logs --previous <pod-name>

# Follow logs in real-time
kubectl logs -f <pod-name>

# View logs from all pods
kubectl logs -l app=my-app --all-containers

# View logs from a specific container
kubectl logs <pod-name> -c <container-name>
```

### Log Aggregation
- **ELK Stack**: Elasticsearch, Logstash, Kibana
- **EFK Stack**: Elasticsearch, Fluentd, Kibana
- **Loki**: Lightweight log aggregation

## Monitoring

### Metrics Server
```bash
# Install metrics server
minikube addons enable metrics-server

# View resource usage
kubectl top nodes
kubectl top pods
```

### Prometheus + Grafana
- **Prometheus**: Metrics collection and alerting
- **Grafana**: Visualization and dashboards
- **kube-prometheus-stack**: All-in-one solution

## Health Probes

### Liveness Probe
- Checks if container is running
- Restarts container if probe fails

```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 15
  periodSeconds: 10
```

### Readiness Probe
- Checks if container is ready to serve traffic
- Removes Pod from Service if probe fails

```yaml
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10
```

### Startup Probe
- Checks if application has started
- Disables other probes until success

```yaml
startupProbe:
  httpGet:
    path: /healthz
    port: 8080
  failureThreshold: 30
  periodSeconds: 10
```

## Debugging

### Common Debug Commands
```bash
# Describe a resource
kubectl describe <resource> <name>

# Get events
kubectl get events --sort-by='.lastTimestamp'

# Execute into a pod
kubectl exec -it <pod-name> -- /bin/bash

# Check pod status
kubectl get pods -o wide

# Check resource usage
kubectl top pods
```

### Troubleshooting Guide

| Problem | Solution |
|---------|----------|
| Pod Pending | Check resources, node capacity, events |
| Pod CrashLoopBackOff | Check logs, resource limits, probes |
| Pod OOMKilled | Increase memory limits |
| Service not accessible | Check endpoints, selectors, ports |

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
