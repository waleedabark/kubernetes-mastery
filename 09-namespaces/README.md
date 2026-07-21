# Step 09: Namespaces - Multi-Tenancy in Kubernetes

## What is a Namespace?

A Namespace is a virtual cluster within a physical cluster. It provides a mechanism for isolating groups of resources within a single cluster.

## Why Namespaces?

- **Resource Isolation**: Separate environments (dev, staging, prod)
- **Access Control**: RBAC can be scoped to namespaces
- **Resource Quotas**: Limit resources per namespace
- **Organization**: Logical grouping of related resources

## Default Namespaces

| Namespace | Description |
|-----------|-------------|
| `default` | Default namespace for objects with no namespace |
| `kube-system` | Kubernetes system components |
| `kube-public` | Publicly accessible resources |
| `kube-node-lease` | Node lease data for heartbeat |

## Namespace YAML Structure

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: my-namespace
  labels:
    env: development
```

## Resource Quotas

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: my-quota
  namespace: my-namespace
spec:
  hard:
    requests.cpu: "4"
    requests.memory: 8Gi
    limits.cpu: "8"
    limits.memory: 16Gi
    pods: "20"
    services: "10"
```

## Limit Ranges

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: my-limit-range
  namespace: my-namespace
spec:
  limits:
  - default:
      cpu: "1"
      memory: 512Mi
    defaultRequest:
      cpu: "0.25"
      memory: 128Mi
    type: Container
```

## Common Commands

```bash
# List namespaces
kubectl get namespaces

# Create a namespace
kubectl create namespace my-namespace

# Delete a namespace
kubectl delete namespace my-namespace

# Get resources in a namespace
kubectl get pods -n my-namespace

# Set default namespace
kubectl config set-context --current --namespace=my-namespace
```

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
