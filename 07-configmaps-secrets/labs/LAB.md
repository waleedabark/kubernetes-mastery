# Lab 07: ConfigMaps & Secrets

## Prerequisites
- Kubernetes cluster running
- kubectl configured

## Lab 1: Create a ConfigMap

```bash
# Create ConfigMap from command line
kubectl create configmap app-config --from-literal=APP_ENV=production --from-literal=APP_DEBUG=false

# Check the ConfigMap
kubectl get configmap app-config -o yaml

# Create ConfigMap from file
echo -e "database.host=mysql-service\ndatabase.port=3306" > config.txt
kubectl create configmap db-config --from-file=config.txt

# Check the ConfigMap
kubectl get configmap db-config -o yaml
```

## Lab 2: Use ConfigMap as Environment Variables

```bash
# Apply the ConfigMap and deployment
kubectl apply -f ../demos/01-configmap-env.yaml

# Check the pod
kubectl get pods

# Exec into the pod and check env vars
kubectl exec -it <pod-name> -- env | grep APP_

# Expected output:
# APP_ENV=production
# APP_DEBUG=false
# APP_NAME=my-app
```

## Lab 3: Use ConfigMap as Volume

```bash
# Apply the ConfigMap and deployment
kubectl apply -f ../demos/02-configmap-volume.yaml

# Check the pod
kubectl get pods

# Exec into the pod and check the mounted file
kubectl exec -it <pod-name> -- cat /etc/config/application.properties

# Expected output:
# database.host=mysql-service
# database.port=3306
# cache.ttl=3600
```

## Lab 4: Create a Secret

```bash
# Create Secret from command line
kubectl create secret generic db-credentials --from-literal=username=admin --from-literal=password='P@ssw0rd!'

# Check the Secret (base64 encoded)
kubectl get secret db-credentials -o yaml

# Decode the Secret
kubectl get secret db-credentials -o jsonpath='{.data.username}' | base64 --decode
kubectl get secret db-credentials -o jsonpath='{.data.password}' | base64 --decode
```

## Lab 5: Use Secret as Environment Variable

```bash
# Apply the Secret and deployment
kubectl apply -f ../demos/03-secret-env.yaml

# Check the pod
kubectl get pods

# Exec into the pod and check env vars
kubectl exec -it <pod-name> -- env | grep DB_

# Expected output:
# DB_USERNAME=admin
# DB_PASSWORD=P@ssw0rd!
```

## Lab 6: Use Secret as Volume

```bash
# Apply the Secret and deployment
kubectl apply -f ../demos/04-secret-volume.yaml

# Check the pod
kubectl get pods

# Exec into the pod and check the mounted file
kubectl exec -it <pod-name> -- cat /etc/secrets/username
kubectl exec -it <pod-name> -- cat /etc/secrets/password
```

## Lab 7: Update ConfigMap

```bash
# Apply the initial ConfigMap
kubectl apply -f ../demos/01-configmap-env.yaml

# Edit the ConfigMap
kubectl edit configmap app-config

# Change APP_ENV to staging

# Restart the pod to pick up changes
kubectl rollout restart deployment configmap-demo

# Check the new env vars
kubectl exec -it <new-pod-name> -- env | grep APP_
```

## Challenge

1. Create a ConfigMap with a JSON file
2. Create a Secret with a TLS certificate
3. Use a ConfigMap to configure nginx.conf
4. Use a Secret to store Docker registry credentials

## Cleanup

```bash
kubectl delete configmap --all
kubectl delete secret --all
kubectl delete deployment --all
```

## Next Step

When done, proceed to [Step 08: Volumes & Storage](../08-volumes-storage/)
