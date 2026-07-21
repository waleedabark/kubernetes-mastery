# Demo: Kubernetes Cluster Exploration

This demo helps you explore and understand your Kubernetes cluster.

## Step 1: Check Cluster Overview

```bash
# View all nodes in the cluster
kubectl get nodes -o wide

# View cluster info
kubectl cluster-info

# Check what's running in all namespaces
kubectl get pods --all-namespaces
```

## Step 2: Understand Namespaces

```bash
# List all namespaces
kubectl get namespaces

# List pods in default namespace
kubectl get pods -n default

# List pods in kube-system namespace (system components)
kubectl get pods -n kube-system
```

## Step 3: Explore a System Pod

```bash
# Find a running pod in kube-system
kubectl get pods -n kube-system

# Describe it to see details
kubectl describe pod <pod-name> -n kube-system

# Look at the events section at the bottom - this shows what happened
```

## Step 4: Resource Usage

```bash
# Check node resource usage
kubectl top nodes

# Check pod resource usage
kubectl top pods

# If metrics-server isn't installed, install it:
# minikube addons enable metrics-server
```

## Step 5: Dry Run and Generate YAML

```bash
# Generate YAML without creating (dry run)
kubectl run test-pod --image=nginx --dry-run=client -o yaml

# Save to file
kubectl run test-pod --image=nginx --dry-run=client -o yaml > generated-pod.yaml

# Generate a deployment YAML
kubectl create deployment web --image=nginx --dry-run=client -o yaml > generated-deployment.yaml

# View the generated files
cat generated-pod.yaml
cat generated-deployment.yaml
```

## Expected Output

```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: test-pod
  name: test-pod
spec:
  containers:
  - image: nginx
    name: test-pod
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

## Cleanup

```bash
rm -f generated-pod.yaml generated-deployment.yaml
```

## Key Takeaways

1. `kubectl get` - List resources
2. `kubectl describe` - Detailed info about a resource
3. `kubectl logs` - View container logs
4. `kubectl exec` - Execute commands in a container
5. `kubectl top` - Resource usage
6. `--dry-run=client -o yaml` - Generate YAML templates
