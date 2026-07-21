# Lab 05: Deployments

## Prerequisites
- Kubernetes cluster running
- kubectl configured

## Lab 1: Create Your First Deployment

```bash
# Apply the deployment manifest
kubectl apply -f ../demos/01-basic-deployment.yaml

# Check deployment status
kubectl get deployments

# Watch rollout status
kubectl rollout status deployment/nginx-deployment

# Check pods
kubectl get pods -o wide
```

## Lab 2: Scaling Deployments

```bash
# Scale using kubectl
kubectl scale deployment nginx-deployment --replicas=5

# Watch new pods come up
kubectl get pods -w

# Scale down
kubectl scale deployment nginx-deployment --replicas=2

# Verify
kubectl get deployment nginx-deployment
```

## Lab 3: Rolling Update

```bash
# Check current image
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[0].image}'

# Update the image (this triggers a rolling update)
kubectl set image deployment/nginx-deployment nginx=nginx:1.22

# Watch the rollout
kubectl rollout status deployment/nginx-deployment

# Check the ReplicaSets (old and new should exist)
kubectl get rs

# Check the pods
kubectl get pods
```

## Lab 4: Rollback

```bash
# Check rollout history
kubectl rollout history deployment/nginx-deployment

# Undo the last rollout
kubectl rollout undo deployment/nginx-deployment

# Watch it roll back
kubectl rollout status deployment/nginx-deployment

# Verify the image is back to original
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[0].image}'
```

## Lab 5: Edit Deployment

```bash
# Edit the deployment directly
kubectl edit deployment nginx-deployment

# Change replicas: 3 to replicas: 5

# Save and exit

# Verify the change
kubectl get deployment nginx-deployment
```

## Lab 6: Deployment with Readiness Probe

```bash
# Apply deployment with readiness probe
kubectl apply -f ../demos/02-deployment-with-probes.yaml

# Watch pods come up (some may take time to become ready)
kubectl get pods -w

# Check readiness status
kubectl get pods
```

## Lab 7: Deployment with Environment Variables

```bash
# Apply deployment with env vars
kubectl apply -f ../demos/03-deployment-with-env.yaml

# Check environment variables in the pod
kubectl exec -it <pod-name> -- env

# Verify the env vars are set
```

## Lab 8: Pause and Resume

```bash
# Pause the deployment
kubectl rollout pause deployment/nginx-deployment

# Make changes (they won't apply yet)
kubectl set image deployment/nginx-deployment nginx=nginx:1.23
kubectl scale deployment nginx-deployment --replicas=10

# Resume to apply all changes at once
kubectl rollout resume deployment/nginx-deployment

# Watch the rollout
kubectl rollout status deployment/nginx-deployment
```

## Cleanup

```bash
kubectl delete deployment --all
```

## Next Step

When done, proceed to [Step 06: Services](../06-services/)
