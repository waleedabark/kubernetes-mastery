# Lab 04: ReplicaSets

## Prerequisites
- Kubernetes cluster running
- kubectl configured

## Lab 1: Create Your First ReplicaSet

```bash
# Apply the ReplicaSet manifest
kubectl apply -f ../demos/01-basic-replicaset.yaml

# Check the ReplicaSet
kubectl get rs

# Check the Pods created
kubectl get pods

# Verify 3 pods are running
kubectl get pods --show-labels
```

## Lab 2: Scale the ReplicaSet

```bash
# Scale to 5 replicas using kubectl
kubectl scale rs nginx-rs --replicas=5

# Watch the pods come up
kubectl get pods -w

# Check the ReplicaSet status
kubectl describe rs nginx-rs

# Scale down to 2
kubectl scale rs nginx-rs --replicas=2

# Watch pods being terminated
kubectl get pods -w
```

## Lab 3: Edit ReplicaSet (Declarative)

```bash
# Edit the ReplicaSet
kubectl edit rs nginx-rs

# Change replicas: 3 to replicas: 4

# Save and exit

# Verify the change
kubectl get rs nginx-rs
```

## Lab 4: ReplicaSet Self-Healing

```bash
# List pods
kubectl get pods

# Delete one pod
kubectl delete pod <pod-name>

# Immediately check - a new pod should appear
kubectl get pods

# Watch it being recreated
kubectl get pods -w
```

## Lab 5: ReplicaSet Selectors

```bash
# Create a ReplicaSet with specific labels
kubectl apply -f ../demos/02-replicaset-selectors.yaml

# List all pods with labels
kubectl get pods --show-labels

# Filter by label
kubectl get pods -l app=web,tier=frontend

# Describe the ReplicaSet to see selector
kubectl describe rs frontend-rs
```

## Lab 6: Cleanup

```bash
# Delete all ReplicaSets and Pods
kubectl delete rs --all
kubectl delete pod --all
```

## Challenge

1. Create a ReplicaSet with 4 replicas of nginx:1.20
2. Create a ReplicaSet with 2 different containers
3. Scale a ReplicaSet using a YAML file (edit + apply)
4. Observe what happens when you delete ALL pods managed by a ReplicaSet

## Next Step

When done, proceed to [Step 05: Deployments](../05-deployments/)
