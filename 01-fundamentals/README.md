# Step 01: Kubernetes Fundamentals & Architecture

## What is Kubernetes?

Kubernetes (K8s) is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications.

## Why Kubernetes?

- **Automated scheduling** - Automatically places containers based on resource requirements
- **Self-healing** - Restarts failed containers, replaces and reschedules nodes
- **Horizontal scaling** - Scale up/down with a command or automatically
- **Service discovery & load balancing** - DNS name and IP for containers
- **Automated rollouts & rollbacks** - Gradual application changes with monitoring
- **Secret & configuration management** - Deploy secrets without rebuilding images
- **Storage orchestration** - Automatically mount storage systems

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                        CONTROL PLANE                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐  │
│  │    API       │  │  Scheduler   │  │  Controller Manager  │  │
│  │   Server     │  │              │  │                      │  │
│  └──────────────┘  └──────────────┘  └──────────────────────┘  │
│  ┌──────────────┐  ┌──────────────────────────────────────┐    │
│  │  etcd        │  │  Cloud Controller Manager (optional) │    │
│  │  (data store)│  └──────────────────────────────────────┘    │
│  └──────────────┘                                              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         WORKER NODES                             │
│  ┌─────────────────────┐  ┌─────────────────────┐              │
│  │      Node 1         │  │      Node 2         │  ...        │
│  │  ┌───────────────┐  │  │  ┌───────────────┐  │              │
│  │  │    kubelet    │  │  │  │    kubelet    │  │              │
│  │  ├───────────────┤  │  │  ├───────────────┤  │              │
│  │  │  kube-proxy   │  │  │  │  kube-proxy   │  │              │
│  │  ├───────────────┤  │  │  ├───────────────┤  │              │
│  │  │ Container Runt│  │  │  │ Container Runt│  │              │
│  │  │  (Docker/     │  │  │  │  (Docker/     │  │              │
│  │  │   containerd) │  │  │  │   containerd) │  │              │
│  │  ├───────────────┤  │  │  ├───────────────┤  │              │
│  │  │ ┌───┐ ┌───┐  │  │  │  │ ┌───┐ ┌───┐  │  │              │
│  │  │ │ P1│ │ P2│  │  │  │  │ │ P3│ │ P4│  │  │              │
│  │  │ └───┘ └───┘  │  │  │  │ └───┘ └───┘  │  │              │
│  │  └───────────────┘  │  │  └───────────────┘  │              │
│  └─────────────────────┘  └─────────────────────┘              │
└─────────────────────────────────────────────────────────────────┘
```

## Control Plane Components

### 1. API Server (kube-apiserver)
- The front-end for the Kubernetes control plane
- Exposes the Kubernetes API
- All communication goes through the API server
- Validates and processes REST requests

### 2. etcd
- Consistent and highly available key-value store
- The backing store for all cluster data
- Stores cluster state and configuration
- Only the API server talks to etcd directly

### 3. Scheduler (kube-scheduler)
- Watches for newly created Pods with no assigned node
- Selects a node for them to run on
- Considers resource requirements, hardware, policies, and constraints

### 4. Controller Manager (kube-controller-manager)
- Runs controller processes (control loops)
- Different controllers for different resources:
  - **Node Controller** - Notifies when nodes go down
  - **Replication Controller** - Maintains correct number of pods
  - **Endpoint Controller** - Populates Endpoints objects
  - **Service Account Controller** - Creates default service accounts

### 5. Cloud Controller Manager (optional)
- Embeds cloud-specific control logic
- Lets you link your cluster to cloud provider APIs

## Worker Node Components

### 1. kubelet
- An agent that runs on each node
- Ensures containers are running in a Pod
- Receives PodSpecs and ensures described containers are running

### 2. kube-proxy
- Maintains network rules on nodes
- Enables Service abstraction
- Handles TCP/UDP forwarding

### 3. Container Runtime
- The software responsible for running containers
- Examples: Docker, containerd, CRI-O
- Must implement the Container Runtime Interface (CRI)

## Core Objects

| Object | Description |
|--------|-------------|
| **Pod** | Smallest deployable unit; one or more containers |
| **ReplicaSet** | Maintains a stable set of replica Pods |
| **Deployment** | Manages ReplicaSets and provides updates |
| **Service** | Stable network endpoint for a set of Pods |
| **Namespace** | Virtual cluster within a physical cluster |
| **ConfigMap** | Non-confidential key-value pairs |
| **Secret** | Sensitive data (passwords, tokens, keys) |

## Key Concepts

### Declarative vs Imperative
- **Declarative**: Describe desired state in YAML, K8s makes it happen
- **Imperative**: Tell K8s exactly what to do, step by step
- **Best practice**: Use declarative (YAML files) for production

### Desired State
You tell Kubernetes what you want (desired state), and it works to make the cluster match that state (reconciliation loop).

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
