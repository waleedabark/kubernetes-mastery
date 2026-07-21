# Lab 08: Volumes & Storage

## Prerequisites
- Kubernetes cluster running
- kubectl configured

## Lab 1: emptyDir Volume

```bash
# Apply the emptyDir demo
kubectl apply -f ../demos/01-emptydir-volume.yaml

# Check the pod
kubectl get pods

# Exec into the pod and write data
kubectl exec -it emptydir-demo -- sh -c 'echo "Hello from emptyDir" > /data/hello.txt'

# Check the data
kubectl exec -it emptydir-demo -- cat /data/hello.txt

# Delete the pod and recreate - data is gone!
kubectl delete pod emptydir-demo
kubectl apply -f ../demos/01-emptydir-volume.yaml
kubectl exec -it emptydir-demo -- ls /data/
```

## Lab 2: hostPath Volume

```bash
# Apply the hostPath demo
kubectl apply -f ../demos/02-hostpath-volume.yaml

# Check the pod
kubectl get pods

# Write data to the volume
kubectl exec -it hostpath-demo -- sh -c 'echo "Hello from hostPath" > /data/hello.txt'

# Check the data on the host (if you have access)
# For Minikube: minikube ssh 'cat /mnt/data/hello.txt'
```

## Lab 3: PersistentVolume and PersistentVolumeClaim

```bash
# Create a PersistentVolume
kubectl apply -f ../demos/03-pv-pvc.yaml

# Check PV
kubectl get pv

# Check PVC
kubectl get pvc

# Check the PVC is bound
kubectl describe pvc my-pvc

# Apply a pod that uses the PVC
kubectl apply -f ../demos/04-pvc-pod.yaml

# Write data
kubectl exec -it pvc-demo -- sh -c 'echo "Hello from PVC" > /data/hello.txt'

# Check data
kubectl exec -it pvc-demo -- cat /data/hello.txt
```

## Lab 4: Storage with ConfigMap

```bash
# Apply the ConfigMap volume demo
kubectl apply -f ../demos/05-configmap-volume.yaml

# Check the pod
kubectl get pods

# Check mounted files
kubectl exec -it configmap-volume-demo -- ls /etc/config/
kubectl exec -it configmap-volume-demo -- cat /etc/config/application.properties
```

## Lab 5: Multiple Volumes

```bash
# Apply pod with multiple volumes
kubectl apply -f ../demos/06-multi-volume.yaml

# Check the pod
kubectl get pods

# Check both volumes are mounted
kubectl exec -it multi-volume-demo -- ls /data1/
kubectl exec -it multi-volume-demo -- ls /data2/
```

## Cleanup

```bash
kubectl delete pv --all
kubectl delete pvc --all
kubectl delete pod --all
kubectl delete configmap --all
```

## Next Step

When done, proceed to [Step 09: Namespaces](../09-namespaces/)
