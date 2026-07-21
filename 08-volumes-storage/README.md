# Step 08: Volumes & Storage

## Overview

Kubernetes volumes provide persistent storage for containers. Unlike container storage (which is ephemeral), volumes can persist beyond container restarts.

## Volume Types

| Type | Description | Use Case |
|------|-------------|----------|
| `emptyDir` | Empty directory, deleted when Pod is removed | Scratch space, caching |
| `hostPath` | File/directory from host node | Development, system access |
| `persistentVolumeClaim` | Request for storage | Production storage |
| `configMap` | ConfigMap data as volume | Configuration files |
| `secret` | Secret data as volume | Sensitive data |
| `nfs` | NFS share | Shared storage |
| `awsElasticBlockStore` | AWS EBS volume | AWS storage |
| `persistentVolume` | Pre-provisioned storage | Static provisioning |

## Persistent Volumes (PV) and Claims (PVC)

### Persistent Volume (PV)
A piece of storage in the cluster that has been provisioned by an administrator or dynamically provisioned using Storage Classes.

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /mnt/data
```

### Persistent Volume Claim (PVC)
A request for storage by a user. It is similar to a Pod - Pods consume node resources, PVCs consume PV resources.

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
```

### Storage Class
Defines how volumes are provisioned dynamically.

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
parameters:
  type: pd-ssd
```

## Access Modes

| Mode | Description |
|------|-------------|
| `ReadWriteOnce` | Mounted as read-write by a single node |
| `ReadOnlyMany` | Mounted as read-only by many nodes |
| `ReadWriteMany` | Mounted as read-write by many nodes |

## Reclaim Policies

| Policy | Description |
|--------|-------------|
| `Retain` | PV is kept after PVC is deleted |
| `Delete` | PV is deleted when PVC is deleted |
| `Recycle` | Deprecated, use dynamic provisioning |

## Common Commands

```bash
# List PVs
kubectl get pv

# List PVCs
kubectl get pvc

# Describe PV
kubectl describe pv my-pv

# Describe PVC
kubectl describe pvc my-pvc
```

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
