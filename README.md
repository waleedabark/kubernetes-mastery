# Kubernetes Mastery

> A hands-on, from-zero-to-hero learning path for mastering Kubernetes.

This repository is a structured, 15-step curriculum that takes you from the fundamentals of Kubernetes architecture through to production-grade cluster operations. Each step combines concept documentation, guided labs, and working demos so you learn by doing.

## Table of Contents

- [Learning Path](#learning-path)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Repository Structure](#repository-structure)
- [How to Use This Repository](#how-to-use-this-repository)
- [Contributing](#contributing)
- [License](#license)

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

## Prerequisites

Before you begin, make sure you have:

- Basic knowledge of the command line and Linux fundamentals
- Working knowledge of Docker (helpful for later steps, not required early on)
- A machine with at least 4GB of RAM (8GB recommended)
- A stable internet connection

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

## Contributing

Contributions are welcome! If you find an issue, want to improve a demo, or have an idea for a new lab:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

Please keep changes consistent with the existing structure and style.

## License

Free to use for learning purposes.
