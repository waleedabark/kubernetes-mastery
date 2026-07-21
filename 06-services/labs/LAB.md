# Lab 06: Services

## Prerequisites
- Kubernetes cluster running
- kubectl configured

## Lab 1: ClusterIP Service

```bash
# Create a deployment first
kubectl apply -f ../demos/01-clusterip-service.yaml

# Check the service
kubectl get svc nginx-clusterip

# Check endpoints
kubectl get endpoints nginx-clusterip

# Test internal access from another pod
kubectl run test-pod --rm -it --image=busybox -- /bin/sh

# Inside the test pod, run:
# wget -qO- http://nginx-clusterip
# exit
```

## Lab 2: NodePort Service

```bash
# Apply NodePort service
kubectl apply -f ../demos/02-nodeport-service.yaml

# Check the service
kubectl get svc nginx-nodeport

# Get the NodePort
kubectl get svc nginx-nodeport -o jsonpath='{.spec.ports[0].nodePort}'

# Access via NodePort (replace <node-ip> with your node's IP)
# For Minikube:
minikube service nginx-nodeport --url

# For Docker Desktop:
# http://localhost:<nodeport>

# For cloud providers:
# Use the external IP
```

## Lab 3: LoadBalancer Service

```bash
# Apply LoadBalancer service
kubectl apply -f ../demos/03-loadbalancer-service.yaml

# Check the service
kubectl get svc nginx-loadbalancer

# For cloud providers, check external IP
kubectl get svc nginx-loadbalancer -w

# For Minikube, use tunnel:
minikube tunnel

# For Docker Desktop, use localhost
```

## Lab 4: Service Discovery

```bash
# Create a service
kubectl apply -f ../demos/01-clusterip-service.yaml

# Run a test pod
kubectl run test-pod --rm -it --image=busybox -- /bin/sh

# Inside test pod, resolve DNS:
# nslookup nginx-clusterip
# nslookup nginx-clusterip.default.svc.cluster.local

# Test connectivity:
# wget -qO- http://nginx-clusterip
# exit
```

## Lab 5: Service Endpoints

```bash
# Check endpoints
kubectl get endpoints nginx-clusterip

# Scale the deployment
kubectl scale deployment nginx-deployment --replicas=5

# Check endpoints again (should have more IPs)
kubectl get endpoints nginx-clusterip

# Check the service details
kubectl describe svc nginx-clusterip
```

## Lab 6: Multiple Ports

```bash
# Apply service with multiple ports
kubectl apply -f ../demos/04-multi-port-service.yaml

# Check the service
kubectl get svc multi-port-svc

# Check endpoints
kubectl get endpoints multi-port-svc
```

## Cleanup

```bash
kubectl delete svc --all
kubectl delete deployment --all
kubectl delete pod --all
```

## Next Step

When done, proceed to [Step 07: ConfigMaps & Secrets](../07-configmaps-secrets/)
