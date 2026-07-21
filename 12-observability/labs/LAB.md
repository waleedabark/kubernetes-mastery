# Lab 12: Observability

## Prerequisites
- Kubernetes cluster running
- kubectl configured

## Lab 1: Container Logs

```bash
# Create a deployment
kubectl apply -f ../demos/01-logging-demo.yaml

# View pod logs
kubectl logs -l app=nginx

# Follow logs in real-time
kubectl logs -f -l app=nginx

# View logs with timestamps
kubectl logs -l app=nginx --timestamps

# View previous container logs (if restarted)
kubectl logs --previous -l app=nginx
```

## Lab 2: Health Probes

```bash
# Apply deployment with health probes
kubectl apply -f ../demos/02-health-probes.yaml

# Watch pods become ready
kubectl get pods -w

# Check probe status
kubectl describe pod <pod-name> | grep -A 10 "Liveness\|Readiness"

# Check events
kubectl get events --sort-by='.lastTimestamp'
```

## Lab 3: Resource Monitoring

```bash
# Check if metrics-server is installed
kubectl top nodes

# Check pod resource usage
kubectl top pods

# Check specific pod resources
kubectl top pod <pod-name> --containers
```

## Lab 4: Debugging Pods

```bash
# Apply a deployment
kubectl apply -f ../demos/03-debugging-demo.yaml

# Check pod status
kubectl get pods -o wide

# Describe the pod
kubectl describe pod <pod-name>

# Execute debugging commands
kubectl exec -it <pod-name> -- sh -c 'ps aux'
kubectl exec -it <pod-name> -- sh -c 'netstat -tulpn'
kubectl exec -it <pod-name> -- sh -c 'df -h'
```

## Lab 5: Events and Troubleshooting

```bash
# View all events
kubectl get events --sort-by='.lastTimestamp'

# View events for a specific namespace
kubectl get events -n default

# View events sorted by reason
kubectl get events --sort-by='.reason'
```

## Cleanup

```bash
kubectl delete deployment --all
kubectl delete pod --all
```

## Next Step

When done, proceed to [Step 13: Security & RBAC](../13-security-rbac/)
