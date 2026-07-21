#!/bin/bash
# Kubernetes Environment Setup Script
# This script helps you set up a local Kubernetes environment

set -e

echo "=== Kubernetes Environment Setup ==="
echo ""

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "kubectl not found. Please install kubectl first."
    echo "Visit: https://kubernetes.io/docs/tasks/tools/"
    exit 1
fi

echo "kubectl found: $(kubectl version --client --short 2>/dev/null || kubectl version --client)"
echo ""

# Check for available Kubernetes options
echo "Checking available options..."

# Check for Docker
if command -v docker &> /dev/null; then
    echo "✓ Docker is installed"
    DOCKER_AVAILABLE=true
else
    echo "✗ Docker is not installed"
    DOCKER_AVAILABLE=false
fi

# Check for Minikube
if command -v minikube &> /dev/null; then
    echo "✓ Minikube is installed"
    MINIKUBE_AVAILABLE=true
else
    echo "✗ Minikube is not installed"
    MINIKUBE_AVAILABLE=false
fi

# Check for Kind
if command -v kind &> /dev/null; then
    echo "✓ Kind is installed"
    KIND_AVAILABLE=true
else
    echo "✗ Kind is not installed"
    KIND_AVAILABLE=false
fi

echo ""

# Ask user which option to use
echo "Choose your Kubernetes setup:"
echo "1) Minikube (recommended for beginners)"
echo "2) Kind (Kubernetes in Docker)"
echo "3) Docker Desktop (if already running)"
echo "4) K3s (lightweight)"
echo "5) Skip setup (already have a cluster)"
echo ""
read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        if [ "$MINIKUBE_AVAILABLE" = false ]; then
            echo "Installing Minikube..."
            if [[ "$OSTYPE" == "darwin"* ]]; then
                brew install minikube
            elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
                curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
                sudo install minikube-linux-amd64 /usr/local/bin/minikube
            fi
        fi
        echo "Starting Minikube..."
        minikube start --cpus=4 --memory=8192
        minikube addons enable metrics-server
        echo "✓ Minikube is ready!"
        ;;
    2)
        if [ "$KIND_AVAILABLE" = false ]; then
            echo "Please install Kind first: https://kind.sigs.k8s.io/docs/user/quick-start/#installation"
            exit 1
        fi
        echo "Creating Kind cluster..."
        kind create cluster --name k8s-lab
        echo "✓ Kind cluster is ready!"
        ;;
    3)
        echo "Please ensure Docker Desktop has Kubernetes enabled:"
        echo "Settings > Kubernetes > Enable Kubernetes"
        echo "Then click 'Apply & Restart'"
        ;;
    4)
        echo "Installing K3s..."
        curl -sfL https://get.k3s.io | sh -
        export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
        echo "✓ K3s is ready!"
        ;;
    5)
        echo "Skipping setup..."
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "=== Verifying Installation ==="
kubectl get nodes
echo ""
echo "✓ Kubernetes environment is ready!"
echo "You can now proceed to the labs and demos."
