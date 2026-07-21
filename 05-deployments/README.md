# Step 05: Deployments - The Production Workhorse

## What is a Deployment?

A Deployment provides declarative updates for Pods and ReplicaSets. You describe a desired state, and the Deployment controller changes the actual state to the desired state at a controlled rate.

## Deployment Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Deployment                           │
│  ┌─────────────────────────────────────────────────┐   │
│  │              ReplicaSet v1                      │   │
│  │  ┌─────┐  ┌─────┐  ┌─────┐                    │   │
│  │  │Pod 1│  │Pod 2│  │Pod 3│  (nginx:1.20)      │   │
│  │  └─────┘  └─────┘  └─────┘                    │   │
│  └─────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────┐   │
│  │              ReplicaSet v2 (new)                │   │
│  │  ┌─────┐  ┌─────┐  ┌─────┐                    │   │
│  │  │Pod 4│  │Pod 5│  │Pod 6│  (nginx:1.21)      │   │
│  │  └─────┘  └─────┘  └─────┘                    │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

## Deployment Strategies

### 1. Rolling Update (Default)
- Gradually replaces old pods with new ones
- Ensures zero downtime
- Configurable maxSurge and maxUnavailable

```
Step 1: [v1] [v1] [v1]
Step 2: [v1] [v1] [v1] [v2]        (maxSurge: 1)
Step 3: [v1] [v1] [v2]             (maxUnavailable: 1)
Step 4: [v1] [v2] [v2]
Step 5: [v2] [v2] [v2]
```

### 2. Recreate
- Terminates all old pods before creating new ones
- Causes downtime
- Use when you can't have two versions running

## Deployment YAML Structure

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
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

### 1. Rolling Updates
- **maxSurge**: Maximum number of pods above desired count
- **maxUnavailable**: Maximum pods that can be unavailable

### 2. Rollback
- Every update creates a new ReplicaSet
- Can roll back to previous versions
- Revision history is maintained

### 3. Pause/Resume
- Pause a deployment to make multiple changes
- Resume to apply all changes at once

## Common Commands

```bash
# Create a deployment
kubectl apply -f deployment.yaml

# Check deployment status
kubectl get deployments
kubectl rollout status deployment/my-deployment

# Update deployment
kubectl set image deployment/my-deployment nginx=nginx:1.22

# Rollback deployment
kubectl rollout undo deployment/my-deployment

# Check rollout history
kubectl rollout history deployment/my-deployment

# Pause/Resume deployment
kubectl rollout pause deployment/my-deployment
kubectl rollout resume deployment/my-deployment
```

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
