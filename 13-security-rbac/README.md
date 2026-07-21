# Step 13: Security & RBAC

## Overview

Kubernetes security involves multiple layers: cluster security, pod security, network security, and access control.

## Security Layers

```
┌─────────────────────────────────────────────────────────┐
│                    Cluster Security                      │
│  ┌─────────────────────────────────────────────────┐   │
│  │                 RBAC                            │   │
│  │  ┌─────────────────────────────────────────┐   │   │
│  │  │              Pod Security                │   │   │
│  │  │  ┌─────────────────────────────────┐    │   │   │
│  │  │  │         Container Security      │    │   │   │
│  │  │  │  ┌─────────────────────────┐    │    │   │   │
│  │  │  │  │    Application Security │    │    │   │   │
│  │  │  │  └─────────────────────────┘    │    │   │   │
│  │  │  └─────────────────────────────────┘    │   │   │
│  │  └─────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

## Role-Based Access Control (RBAC)

### Components

| Component | Description |
|-----------|-------------|
| **Role** | Defines permissions within a namespace |
| **ClusterRole** | Defines permissions cluster-wide |
| **RoleBinding** | Binds Role to users/groups/service accounts |
| **ClusterRoleBinding** | Binds ClusterRole to users/groups/service accounts |

### Role YAML

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
  namespace: default
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["get", "list"]
```

### RoleBinding YAML

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: jane
  apiGroup: rbac.authorization.k8s.io
- kind: ServiceAccount
  name: my-sa
  namespace: default
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

## Pod Security Standards

### Privileged
- Unrestricted
- Full access to all privileges
- Use only for system pods

### Baseline
- Minimally restrictive
- Prevents known privilege escalations
- Good starting point

### Restricted
- Heavily restricted
- Follows pod hardening best practices
- Use for security-critical workloads

## Security Best Practices

### 1. Run as Non-Root
```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1000
```

### 2. Read-Only Root Filesystem
```yaml
securityContext:
  readOnlyRootFilesystem: true
```

### 3. Drop Capabilities
```yaml
securityContext:
  capabilities:
    drop:
    - ALL
```

### 4. Resource Limits
```yaml
resources:
  limits:
    cpu: "1"
    memory: 512Mi
  requests:
    cpu: "0.5"
    memory: 256Mi
```

### 5. Use Network Policies
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

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
