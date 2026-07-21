# Lab 14: Advanced Patterns

## Prerequisites
- Kubernetes cluster running
- kubectl configured

## Lab 1: Custom Resource Definitions

```bash
# Apply a CRD
kubectl apply -f ../demos/01-crd.yaml

# Check the CRD
kubectl get crds

# Create a custom resource
kubectl apply -f ../demos/02-custom-resource.yaml

# Check the custom resource
kubectl get crontabs

# Describe the custom resource
kubectl describe crontab my-crontab
```

## Lab 2: StatefulSet

```bash
# Apply a StatefulSet
kubectl apply -f ../demos/03-statefulset.yaml

# Check the StatefulSet
kubectl get statefulsets

# Watch pods come up in order
kubectl get pods -w

# Check the PersistentVolumeClaims
kubectl get pvc

# Check the headless service
kubectl get svc nginx
```

## Lab 3: Job

```bash
# Apply a Job
kubectl apply -f ../demos/04-job.yaml

# Check the Job
kubectl get jobs

# Check the Pod status
kubectl get pods

# Watch the Job complete
kubectl get jobs -w
```

## Lab 4: CronJob

```bash
# Apply a CronJob
kubectl apply -f ../demos/05-cronjob.yaml

# Check the CronJob
kubectl get cronjobs

# Wait for a schedule to trigger
kubectl get jobs

# Check the Pod status
kubectl get pods
```

## Lab 5: Sidecar Pattern

```bash
# Apply a sidecar pod
kubectl apply -f ../demos/06-sidecar.yaml

# Check the pod
kubectl get pods

# Check the main container
kubectl exec -it sidecar-demo -c main-app -- ls /var/log

# Check the sidecar container
kubectl exec -it sidecar-demo -c sidecar -- ls /var/log
```

## Cleanup

```bash
kubectl delete crontabs --all
kubectl delete statefulsets --all
kubectl delete jobs --all
kubectl delete cronjobs --all
kubectl delete pods --all
kubectl delete pvc --all
```

## Next Step

When done, proceed to [Step 15: Production Ready](../15-production-ready/)
