# Lab 01: Kubernetes Fundamentals

## Prerequisites
- kubectl installed
- A Kubernetes cluster running (Minikube, Kind, or cloud)

## Lab 1: Verify Cluster Connection

```bash
# Check cluster info
kubectl cluster-info

# Check cluster status
kubectl get nodes -o wide

# Check all components
kubectl get componentstatuses
```

**Expected output**: You should see at least one node in "Ready" state.

## Lab 2: Explore the API Server

```bash
# List all API resources available
kubectl api-resources

# List API versions
kubectl api-versions

# Get cluster version
kubectl version --short
```

**Question**: What API resources are available that start with "deploy"?

## Lab 3: Your First Deployment (Imperative)

```bash
# Create a deployment imperatively
kubectl create deployment nginx-demo --image=nginx:latest

# Watch it come up
kubectl get pods -w

# Once running, check the deployment
kubectl get deployment nginx-demo

# Describe the deployment
kubectl describe deployment nginx-demo
```

## Lab 4: Inspect the Deployment

```bash
# See the ReplicaSet created by the deployment
kubectl get replicasets

# See the Pod created by the ReplicaSet
kubectl get pods

# Get detailed info about the Pod
kubectl describe pod <pod-name>

# Check Pod logs
kubectl logs <pod-name>

# Execute into the Pod
kubectl exec -it <pod-name> -- /bin/bash
# Inside the Pod, run:
#   hostname
#   cat /etc/os-release
#   exit
```

## Lab 5: Clean Up

```bash
# Delete the deployment
kubectl delete deployment nginx-demo

# Verify everything is deleted
kubectl get pods
kubectl get deployments
kubectl get replicasets
```

## Challenge Questions

1. What is the default namespace? (Hint: `kubectl config view`)
2. What is the difference between `kubectl get` and `kubectl describe`?
3. How would you get YAML output for a resource?
4. What happens if you delete a Pod managed by a ReplicaSet?

## Answers

1. The default namespace is `default`
2. `get` shows basic info, `describe` shows detailed events and configuration
3. `kubectl get <resource> <name> -o yaml`
4. The ReplicaSet will create a new Pod to maintain the desired replica count

## Next Step

When done, proceed to [Step 02: Setup Environment](../02-setup-environment/)
