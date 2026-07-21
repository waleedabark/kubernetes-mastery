# Lab 11: Networking & Ingress

## Prerequisites
- Kubernetes cluster running
- kubectl configured
- Ingress controller installed (e.g., nginx-ingress)

## Lab 1: Network Policies

```bash
# Apply a network policy
kubectl apply -f ../demos/01-network-policy.yaml

# Check the network policy
kubectl get networkpolicies

# Describe the policy
kubectl describe networkpolicy allow-frontend
```

## Lab 2: Ingress Setup

```bash
# Install nginx-ingress controller (Minikube)
minikube addons enable ingress

# Or install via Helm
helm install nginx-ingress ingress-nginx/ingress-nginx

# Check the ingress controller
kubectl get pods -n ingress-nginx
```

## Lab 3: Create Ingress

```bash
# Apply the ingress manifest
kubectl apply -f ../demos/02-ingress.yaml

# Check the ingress
kubectl get ingress

# Describe the ingress
kubectl describe ingress my-ingress

# Test the ingress (update /etc/hosts or use curl)
curl -H "Host: app.example.com" http://<ingress-ip>/
```

## Lab 4: Ingress with TLS

```bash
# Create a TLS secret
kubectl create secret tls my-tls-secret --cert=tls.crt --key=tls.key

# Apply ingress with TLS
kubectl apply -f ../demos/03-ingress-tls.yaml

# Check the ingress
kubectl get ingress
```

## Lab 5: Multiple Paths

```bash
# Apply ingress with multiple paths
kubectl apply -f ../demos/04-multiple-paths.yaml

# Test different paths
curl -H "Host: app.example.com" http://<ingress-ip>/
curl -H "Host: app.example.com" http://<ingress-ip>/api
curl -H "Host: app.example.com" http://<ingress-ip>/web
```

## Lab 6: Headless Service

```bash
# Apply headless service
kubectl apply -f ../demos/05-headless-service.yaml

# Check the service
kubectl get svc my-headless-service

# Check endpoints (should have pod IPs directly)
kubectl get endpoints my-headless-service

# Test DNS resolution
kubectl run test-pod --rm -it --image=busybox -- /bin/sh

# Inside test pod:
# nslookup my-headless-service
# exit
```

## Cleanup

```bash
kubectl delete ingress --all
kubectl delete networkpolicies --all
kubectl delete svc --all
kubectl delete deployment --all
kubectl delete pod --all
```

## Next Step

When done, proceed to [Step 12: Observability](../12-observability/)
