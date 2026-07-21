# Lab 09: Namespaces

## Prerequisites
- Kubernetes cluster running
- kubectl configured

## Lab 1: Create Namespaces

```bash
# Create a namespace
kubectl create namespace development

# Create another namespace
kubectl create namespace production

# List all namespaces
kubectl get namespaces
```

## Lab 2: Deploy to Specific Namespace

```bash
# Deploy to development namespace
kubectl apply -f ../demos/01-namespace-deployment.yaml -n development

# Deploy to production namespace
kubectl apply -f ../demos/01-namespace-deployment.yaml -n production

# Check pods in development
kubectl get pods -n development

# Check pods in production
kubectl get pods -n production
```

## Lab 3: Resource Quotas

```bash
# Apply resource quota to development namespace
kubectl apply -f ../demos/02-resource-quota.yaml -n development

# Check the quota
kubectl get resourcequota -n development

# Describe the quota
kubectl describe resourcequota dev-quota -n development
```

## Lab 4: Limit Ranges

```bash
# Apply limit range to development namespace
kubectl apply -f ../demos/03-limit-range.yaml -n development

# Check the limit range
kubectl get limitrange -n development

# Deploy a pod and check its limits
kubectl apply -f ../demos/01-namespace-deployment.yaml -n development

# Check pod resource limits
kubectl get pod -n development -o yaml | grep -A 10 "resources:"
```

## Lab 5: Switch Namespaces

```bash
# Set default namespace to development
kubectl config set-context --current --namespace=development

# Now all commands run in development namespace
kubectl get pods

# Switch to production
kubectl config set-context --current --namespace=production

# Check pods
kubectl get pods
```

## Lab 6: Cross-Namespace Communication

```bash
# Deploy to both namespaces
kubectl apply -f ../demos/01-namespace-deployment.yaml -n development
kubectl apply -f ../demos/04-service-in-namespace.yaml -n development

# From a pod in default namespace, you can reach:
# nginx-service.development.svc.cluster.local
kubectl run test-pod --rm -it --image=busybox -- /bin/sh

# Inside test pod:
# nslookup nginx-service.development
# wget -qO- http://nginx-service.development
# exit
```

## Cleanup

```bash
kubectl delete namespace development
kubectl delete namespace production
```

## Next Step

When done, proceed to [Step 10: Helm Package Manager](../10-helm-package-manager/)
