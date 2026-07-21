# Step 03: Pods - The Building Blocks

## What is a Pod?

A Pod is the smallest deployable unit in Kubernetes. It's a group of one or more containers that:
- Share the same network namespace (same IP address)
- Can share storage volumes
- Are scheduled together on the same node
- Have a lifecycle (they are created, scheduled, and terminated)

## Why Pods?

- **Co-located processes**: Containers that need to work together
- **Shared networking**: Containers in a Pod can communicate via localhost
- **Shared volumes**: Containers can share data through volumes
- **Sidecar pattern**: Support containers alongside main containers

## Pod anatomy

```
┌─────────────────────────────────────────────┐
│                   Pod                        │
│  ┌─────────────┐  ┌─────────────┐           │
│  │  Container  │  │  Container  │  ...      │
│  │    (App)    │  │ (Sidecar)   │           │
│  └─────────────┘  └─────────────┘           │
│  ┌─────────────┐                             │
│  │   Volume    │                             │
│  └─────────────┘                             │
│  ┌──────────────────────────────────────┐   │
│  │         Shared Network (IP)          │   │
│  └──────────────────────────────────────┘   │
└─────────────────────────────────────────────┘
```

## Key Concepts

### Pod Lifecycle
- **Pending**: Accepted but not yet scheduled
- **Running**: At least one container is running
- **Succeeded**: All containers terminated successfully
- **Failed**: At least one container failed
- **Unknown**: Pod state unknown (node unreachable)

### Pod Phases
1. **Scheduled**: Assigned to a node
2. **Pulled**: Container images pulled
3. **Created**: Containers created
4. **Started**: Containers started
5. **Running**: At least one container running

## Pod YAML Structure

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
  labels:
    app: my-app
spec:
  containers:
  - name: my-container
    image: nginx:latest
    ports:
    - containerPort: 80
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```

## Common Pod Patterns

### 1. Single Container Pod (most common)
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-pod
spec:
  containers:
  - name: web
    image: nginx
```

### 2. Multi-Container Pod (Sidecar)
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app-with-logger
spec:
  containers:
  - name: app
    image: my-app
  - name: logger
    image: fluentd
```

### 3. Init Container Pod
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app-with-init
spec:
  initContainers:
  - name: init-myservice
    image: busybox
    command: ['sh', '-c', 'until nslookup myservice; do sleep 2; done']
  containers:
  - name: main-app
    image: nginx
```

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
