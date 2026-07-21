# Lab 03: Pods

## Prerequisites
- Kubernetes cluster running
- kubectl configured

## Lab 1: Create Your First Pod (Imperative)

```bash
# Create a simple nginx pod
kubectl run my-nginx --image=nginx:latest

# Check pod status
kubectl get pods

# Get detailed info
kubectl describe pod my-nginx

# Check the pod is running
kubectl get pods -o wide
```

## Lab 2: Create a Pod from YAML

```bash
# Apply the demo pod manifest
kubectl apply -f ../demos/01-simple-pod.yaml

# Check the pod
kubectl get pods

# Verify it's running
kubectl get pod simple-pod -o yaml
```

## Lab 3: Pod Networking

```bash
# Get the pod IP address
kubectl get pod simple-pod -o jsonpath='{.status.podIP}'

# Execute into a pod and test connectivity
kubectl exec -it simple-pod -- /bin/bash

# Inside the pod, run:
# curl localhost (to test nginx is working)
# exit
```

## Lab 4: Multi-Container Pod

```bash
# Create a pod with two containers
kubectl apply -f ../demos/03-multi-container-pod.yaml

# Check both containers are running
kubectl get pods -w

# Execute into the main container
kubectl exec -it multi-container-pod -c main-app -- /bin/bash

# Execute into the sidecar container
kubectl exec -it multi-container-pod -c sidecar -- /bin/bash
```

## Lab 5: Pod Resource Limits

```bash
# Apply a pod with resource limits
kubectl apply -f ../demos/05-pod-with-resources.yaml

# Check resource allocation
kubectl describe pod resource-pod | grep -A 5 "Limits\|Requests"

# Check actual usage
kubectl top pod resource-pod
```

## Lab 6: Pod Labels and Selectors

```bash
# Apply a pod with labels
kubectl apply -f ../demos/06-pod-with-labels.yaml

# List pods with labels
kubectl get pods --show-labels

# Filter pods by label
kubectl get pods -l app=web
kubectl get pods -l environment=development

# Add a label to a pod
kubectl label pod labeled-pod version=v2

# Remove a label
kubectl label pod labeled-pod version-
```

## Lab 7: Pod Lifecycle

```bash
# Watch pods in real-time
kubectl get pods -w

# In another terminal, create and delete pods
kubectl run test-pod --image=nginx --rm -it -- /bin/bash

# Check pod events
kubectl describe pod <pod-name> | grep -A 5 "Events"
```

## Lab 8: Debugging Pods

```bash
# View pod logs
kubectl logs simple-pod

# View logs with previous container (if restarted)
kubectl logs --previous simple-pod

# Execute debugging commands
kubectl exec -it simple-pod -- cat /etc/nginx/nginx.conf

# Check pod environment variables
kubectl exec -it simple-pod -- env
```

## Challenge

1. Create a pod with 3 containers that share a volume
2. Create a pod that runs a command and then exits
3. Create a pod with environment variables
4. Scale a deployment (we'll learn this in next steps)

## Cleanup

```bash
kubectl delete pod --all
kubectl delete deployment --all
```

## Next Step

When done, proceed to [Step 04: ReplicaSets](../04-replicasets/)
