# Lab 15: Production Ready

## Prerequisites
- Kubernetes cluster running
- kubectl configured
- Helm installed

## Lab 1: Production-Ready Deployment

```bash
# Apply a production-ready deployment
kubectl apply -f ../demos/01-production-deployment.yaml

# Check the deployment
kubectl get deployments

# Check resource limits
kubectl describe deployment production-app | grep -A 10 "Limits\|Requests"

# Check health probes
kubectl describe deployment production-app | grep -A 10 "Liveness\|Readiness"
```

## Lab 2: Network Policies

```bash
# Apply network policies
kubectl apply -f ../demos/02-network-policies.yaml

# Check the policies
kubectl get networkpolicies

# Test connectivity
kubectl run test-pod --rm -it --image=busybox -- /bin/sh

# Inside test pod:
# wget -qO- http://production-app (should fail - denied by default)
# exit
```

## Lab 3: RBAC Setup

```bash
# Apply RBAC configuration
kubectl apply -f ../demos/03-rbac.yaml

# Check the roles and bindings
kubectl get roles
kubectl get rolebindings

# Test permissions
kubectl auth can-i get pods --as=system:serviceaccount:production:app-sa
```

## Lab 4: Horizontal Pod Autoscaler

```bash
# Apply HPA
kubectl apply -f ../demos/04-hpa.yaml

# Check HPA
kubectl get hpa

# Generate load to trigger scaling
kubectl run load-generator --rm -it --image=busybox -- /bin/sh

# Inside load generator:
# while true; do wget -qO- http://production-app; done
# exit

# Watch HPA scale
kubectl get hpa -w
```

## Lab 5: Pod Disruption Budget

```bash
# Apply PDB
kubectl apply -f ../demos/05-pdb.yaml

# Check PDB
kubectl get pdb

# Describe PDB
kubectl describe pdb production-pdb
```

## Lab 6: Monitoring Setup

```bash
# Install metrics-server (if not installed)
minikube addons enable metrics-server

# Check resource usage
kubectl top nodes
kubectl top pods

# Install Prometheus (optional)
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack
```

## Lab 7: Backup Strategy

```bash
# Export all resources
kubectl get all --all-namespaces -o yaml > backup-all.yaml

# Export specific resources
kubectl get deployments -o yaml > backup-deployments.yaml
kubectl get services -o yaml > backup-services.yaml
kubectl get configmaps -o yaml > backup-configmaps.yaml
```

## Cleanup

```bash
kubectl delete deployment --all
kubectl delete service --all
kubectl delete hpa --all
kubectl delete pdb --all
kubectl delete networkpolicies --all
```

## Congratulations!

You've completed the Kubernetes Mastery course! You now have the knowledge to:

1. Deploy and manage applications on Kubernetes
2. Configure networking, storage, and security
3. Monitor and troubleshoot applications
4. Use Helm for package management
5. Implement production-ready deployments

## What's Next?

- Practice with real-world projects
- Contribute to open-source projects
- Get certified (CKA, CKAD, CKS)
- Explore cloud-specific Kubernetes services (EKS, GKE, AKS)
