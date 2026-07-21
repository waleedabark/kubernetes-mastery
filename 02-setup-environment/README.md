# Step 02: Setup Your Kubernetes Environment

## Overview

This step covers setting up a local Kubernetes environment. You'll need one of these options to follow along with the rest of the course.

## Option 1: Minikube (Recommended for Beginners)

### Prerequisites
- Docker or VirtualBox installed
- kubectl installed

### Installation

```bash
# macOS
brew install minikube

# Windows (PowerShell as Admin)
choco install minikube

# Linux
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

### Start Minikube

```bash
# Start with default settings (Docker driver)
minikube start

# Start with more resources
minikube start --cpus=4 --memory=8192

# Enable useful addons
minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable ingress

# Open the dashboard
minikube dashboard
```

## Option 2: Kind (Kubernetes in Docker)

### Prerequisites
- Docker installed
- Go 1.16+ (for building from source)

### Installation

```bash
# macOS
brew install kind

# Windows
go install sigs.k8s.io/kind@latest

# Linux
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

### Create a Cluster

```bash
# Simple single-node cluster
kind create cluster

# Multi-node cluster (create config file first)
cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF

kind create cluster --config kind-config.yaml

# List clusters
kind get clusters

# Delete cluster
kind delete cluster
```

## Option 3: K3s (Lightweight Kubernetes)

### Installation

```bash
# Install K3s
curl -sfL https://get.k3s.io | sh -

# Check installation
sudo k3s kubectl get nodes

# Or use the provided kubectl
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl get nodes

# Uninstall K3s
/usr/local/bin/k3s-uninstall.sh
```

## Option 4: Docker Desktop (Windows/Mac)

1. Install Docker Desktop
2. Go to Settings > Kubernetes
3. Check "Enable Kubernetes"
4. Click "Apply & Restart"
5. Wait for installation to complete

## Verify Your Installation

```bash
# Check kubectl is working
kubectl version --short

# Check cluster is running
kubectl get nodes

# Check system pods
kubectl get pods -n kube-system
```

## Install kubectl

```bash
# macOS
brew install kubectl

# Windows
choco install kubernetes-cli

# Linux
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

## Install Helm (Package Manager)

```bash
# macOS
brew install helm

# Windows
choco install kubernetes-helm

# Linux
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

## Demos

See [demos/](demos/) for environment setup scripts.
