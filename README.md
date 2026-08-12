# Kubernetes Mastery

![Learning Path](https://img.shields.io/badge/learning_path-15_steps-blue)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)
![Free to Use](https://img.shields.io/badge/license-free_to_use-lightgrey)

> A hands-on, from-zero-to-hero learning path for mastering Kubernetes.

This repository is a structured, 15-step curriculum that takes you from the fundamentals of Kubernetes architecture through to production-grade cluster operations. Each step combines concept documentation, guided labs, and working demos so you learn by doing.

## Table of Contents

- [Features](#features)
- [Learning Path](#learning-path)
- [Architecture Diagram](#architecture-diagram)
- [Prerequisites](#prerequisites)
- [Environment Setup](#environment-setup)
- [Getting Started](#getting-started)
- [Repository Structure](#repository-structure)
- [How to Use This Repository](#how-to-use-this-repository)
- [Progress Checklist](#progress-checklist)
- [FAQ](#faq)
- [Contributing](#contributing)
- [License](#license)

## Features

- **15 progressive steps** - A carefully ordered curriculum from fundamentals to production readiness
- **Learn by doing** - Every step pairs concept documentation with hands-on labs and working demos
- **Deploy real workloads** - Pods, ReplicaSets, Deployments, and stateful workloads
- **Manage application config** - ConfigMaps, Secrets, Volumes, and persistent storage
- **Package with Helm** - Build and manage charts like a professional
- **Secure your cluster** - RBAC, networking policies, and security best practices
- **Observe and monitor** - Metrics, logging, and tracing for production systems
- **Production patterns** - Advanced patterns and hardening for real-world deployments

## Learning Path

| Step | Topic | Level | Estimated Duration |
|------|-------|-------|--------------------|
| [01](01-fundamentals) | Fundamentals & Architecture | Beginner | 2-3 hours |
| [02](02-setup-environment) | Setup Environment | Beginner | 1-2 hours |
| [03](03-pods) | Pods | Beginner | 2-3 hours |
| [04](04-replicasets) | ReplicaSets | Beginner | 1-2 hours |
| [05](05-deployments) | Deployments | Intermediate | 3-4 hours |
| [06](06-services) | Services | Intermediate | 3-4 hours |
| [07](07-configmaps-secrets) | ConfigMaps & Secrets | Intermediate | 2-3 hours |
| [08](08-volumes-storage) | Volumes & Storage | Intermediate | 2-3 hours |
| [09](09-namespaces) | Namespaces | Intermediate | 1-2 hours |
| [10](10-helm-package-manager) | Helm Package Manager | Intermediate | 3-4 hours |
| [11](11-networking-ingress) | Networking & Ingress | Advanced | 4-5 hours |
| [12](12-observability) | Observability | Advanced | 4-5 hours |
| [13](13-security-rbac) | Security & RBAC | Advanced | 3-4 hours |
| [14](14-advanced-patterns) | Advanced Patterns | Expert | 5-6 hours |
| [15](15-production-ready) | Production Ready | Expert | 5-6 hours |

## Architecture Diagram

```
Beginner           Intermediate              Advanced               Expert
--------------------------------------------------------------------------------
01 Fundamentals    05 Deployments            11 Networking/Ingress  14 Advanced Patterns
02 Environment     06 Services               12 Observability       15 Production Ready
03 Pods            07 ConfigMaps & Secrets   13 Security & RBAC
04 ReplicaSets     08 Volumes & Storage
                   09 Namespaces
                   10 Helm
```

Each step builds on the last - you should complete them in order.

## Prerequisites

Before you begin, make sure you have:

- Basic knowledge of the command line and Linux fundamentals
- Working knowledge of Docker (helpful for later steps, not required early on)
- A machine with at least 4GB of RAM (8GB recommended)
- A stable internet connection

## Environment Setup

You'll need a local Kubernetes cluster and the core CLI tools. The full setup guide lives in [02-setup-environment](02-setup-environment), but here's the short version:

### Required Tools

- **kubectl** - The Kubernetes command-line tool
- **helm** (from Step 10 onward) - The Kubernetes package manager

### Local Cluster Options (pick one)

| Tool | Recommendation | Notes |
|------|----------------|-------|
| [Minikube](https://minikube.sigs.k8s.io/) | **Recommended** | Easiest to use; includes addons for dashboard, ingress, and metrics-server |
| [kind](https://kind.sigs.k8s.io/) | Good alternative | Runs Kubernetes in Docker containers; great for CI and quick clusters |
| [k3s](https://k3s.io/) | Lightweight option | Minimal footprint; good for resource-constrained machines |

## Getting Started

```bash
# Clone the repository
git clone <repo-url>
cd kubernetes-mastery

# Start with Step 01: Fundamentals & Architecture
cd 01-fundamentals
cat README.md
```

## Repository Structure

Each step follows a consistent structure:

```
XX-topic/
├── README.md          # Concepts & theory
├── labs/              # Hands-on exercises
│   └── LAB.md         # Step-by-step lab instructions
└── demos/             # Working YAML manifests & scripts
    ├── *.yaml
    └── *.sh
```

## How to Use This Repository

1. **Start from Step 01** - Each step builds on the knowledge from the previous one.
2. **Read the step README** - Understand the concepts before touching the cluster.
3. **Complete the labs** - Hands-on exercises reinforce what you've learned.
4. **Run the demos** - Working examples you can execute and inspect.
5. **Break things intentionally** - Breaking and fixing is one of the best ways to learn.
6. **Move on when you're comfortable** - Don't rush; pace yourself.

## Progress Checklist

Track your progress by ticking off each step as you complete it.

- [ ] [01 - Fundamentals & Architecture](01-fundamentals)
- [ ] [02 - Setup Environment](02-setup-environment)
- [ ] [03 - Pods](03-pods)
- [ ] [04 - ReplicaSets](04-replicasets)
- [ ] [05 - Deployments](05-deployments)
- [ ] [06 - Services](06-services)
- [ ] [07 - ConfigMaps & Secrets](07-configmaps-secrets)
- [ ] [08 - Volumes & Storage](08-volumes-storage)
- [ ] [09 - Namespaces](09-namespaces)
- [ ] [10 - Helm Package Manager](10-helm-package-manager)
- [ ] [11 - Networking & Ingress](11-networking-ingress)
- [ ] [12 - Observability](12-observability)
- [ ] [13 - Security & RBAC](13-security-rbac)
- [ ] [14 - Advanced Patterns](14-advanced-patterns)
- [ ] [15 - Production Ready](15-production-ready)

## FAQ

**Do I need a cloud account?**
No. The entire curriculum runs on a local cluster (Minikube, kind, or k3s). No cloud provider is required.

**Which local cluster should I use?**
Minikube is the recommended starting point - it's easy to install, works on all platforms, and includes addons for the dashboard, ingress, and metrics-server used in later steps.

**Do I need Docker experience?**
Working knowledge of Docker helps, but it isn't required for the early steps. Step 02 walks you through setting up your entire environment.

**How long does this take?**
Roughly 40-50 hours total across all 15 steps. Go at your own pace and don't move forward until you're comfortable.

**What if something breaks?**
That's part of the learning process. Try to fix it yourself first, then check the step's labs and demos for reference.

## Contributing

Contributions are welcome! If you find an issue, want to improve a demo, or have an idea for a new lab:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

Please keep changes consistent with the existing structure and style.

## License

Free to use for learning purposes.
