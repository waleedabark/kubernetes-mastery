# Step 04: ReplicaSets

## What is a ReplicaSet?

A ReplicaSet is a Kubernetes object that maintains a stable set of replica Pods running at any given time. It ensures that a specified number of pod replicas are running continuously.

## How ReplicaSets Work

```
ReplicaSet (desired=3)
    │
    ├── Pod 1 (Running) ✓
    ├── Pod 2 (Running) ✓
    └── Pod 3 (Running) ✓

If Pod 2 crashes:
    ├── Pod 1 (Running) ✓
    ├── Pod 2 (Crashed) ✗
    └── Pod 3 (Running) ✓

ReplicaSet automatically creates:
    ├── Pod 1 (Running) ✓
    ├── Pod 2 (New) ✓
    ├── Pod 3 (Running) ✓
    └── Pod 4 (Running) ✓  ← Wait, this is wrong...
    
Actually, ReplicaSet maintains EXACTLY 3 replicas:
    ├── Pod 1 (Running) ✓
    ├── Pod 3 (Running) ✓
    └── Pod 4 (Running) ✓  ← New Pod to replace Pod 2
```

## ReplicaSet YAML Structure

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: my-rs
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
        ports:
        - containerPort: 80
```

## Key Concepts

### 1. Selector
The selector defines which pods the ReplicaSet manages using labels.

### 2. Replicas
The number of identical pods to maintain.

### 3. Template
The pod template used to create new pods.

## ReplicaSet vs Deployment

| Feature | ReplicaSet | Deployment |
|---------|-----------|------------|
| Updates | Manual | Automatic |
| Rollback | No | Yes |
| Scaling | Yes | Yes |
| Self-healing | Yes | Yes |
| Recommended | No | Yes |

**Note**: In practice, you almost always use Deployments, which manage ReplicaSets internally.

## Common Commands

```bash
# Create a ReplicaSet
kubectl apply -f replicaset.yaml

# List ReplicaSets
kubectl get rs

# Describe a ReplicaSet
kubectl describe rs my-rs

# Scale a ReplicaSet
kubectl scale rs my-rs --replicas=5

# Delete a ReplicaSet
kubectl delete rs my-rs
```

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
