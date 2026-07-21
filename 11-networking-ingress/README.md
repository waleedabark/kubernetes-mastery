# Step 11: Networking & Ingress

## Overview

Kubernetes networking is complex but powerful. It handles communication between pods, services, and external traffic.

## Networking Fundamentals

### Pod-to-Pod Communication
- Every Pod gets a unique IP address
- Pods can communicate with all other Pods on all networks
- No NAT required

### Pod-to-Service Communication
- Services provide stable IP and DNS name
- Load balances traffic across Pods
- Uses kube-proxy for network rules

### External-to-Service Communication
- NodePort: Exposes on node's port
- LoadBalancer: Cloud provider load balancer
- Ingress: HTTP/HTTPS routing

## Network Policies

Network Policies control traffic flow between Pods, Namespaces, and external endpoints.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
    ports:
    - protocol: TCP
      port: 80
```

## Ingress

Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster.

### Ingress Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    External Traffic                      │
└───────────────────────┬─────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────┐
│                    Ingress Controller                    │
│                    (nginx, traefik, etc.)                │
└───────────────────────┬─────────────────────────────────┘
                        │
          ┌─────────────┼─────────────┐
          │             │             │
          ▼             ▼             ▼
    ┌──────────┐  ┌──────────┐  ┌──────────┐
    │ Service1 │  │ Service2 │  │ Service3 │
    └──────────┘  └──────────┘  └──────────┘
```

### Ingress YAML Structure

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: app.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```

## Services Deep Dive

### Headless Services
- No cluster IP
- Direct Pod discovery via DNS
- Use case: Stateful applications

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-headless-service
spec:
  clusterIP: None
  selector:
    app: my-app
  ports:
  - port: 80
```

## Common Commands

```bash
# List network policies
kubectl get networkpolicies

# List ingress
kubectl get ingress

# Describe ingress
kubectl describe ingress my-ingress

# Check endpoints
kubectl get endpoints my-service
```

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
