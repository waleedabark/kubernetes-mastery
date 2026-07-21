# Lab 10: Helm Package Manager

## Prerequisites
- Kubernetes cluster running
- kubectl configured
- Helm installed

## Lab 1: Add Repositories

```bash
# Add official Helm repositories
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# Update repositories
helm repo update

# Search for charts
helm search repo nginx
helm search repo nginx --versions
```

## Lab 2: Install a Chart

```bash
# Install nginx chart
helm install my-nginx bitnami/nginx

# Check the release
helm list

# Check the pods
kubectl get pods

# Check the services
kubectl get svc
```

## Lab 3: Customize Installation

```bash
# Install with custom values
helm install my-nginx bitnami/nginx \
  --set replicaCount=3 \
  --set service.type=ClusterIP

# Check the release
helm list

# Check the deployment
kubectl get deployment
```

## Lab 4: Create a Chart

```bash
# Create a new chart
helm create mychart

# Check the chart structure
ls -la mychart/

# Edit values.yaml
# Change replicaCount to 3
# Change image.tag to "1.21"

# Lint the chart
helm lint mychart/

# Template the chart (dry run)
helm template myrelease mychart/
```

## Lab 5: Package and Install Your Chart

```bash
# Package the chart
helm package mychart/

# Install your chart
helm install my-release ./mychart/

# Check the release
helm list

# Check the resources
kubectl get all
```

## Lab 6: Upgrade and Rollback

```bash
# Upgrade the release
helm upgrade my-release ./mychart/ --set replicaCount=5

# Check the upgrade
helm list
kubectl get deployment

# Rollback the release
helm rollback my-release 1

# Check the rollback
kubectl get deployment
```

## Lab 7: Uninstall and Cleanup

```bash
# Uninstall the release
helm uninstall my-release

# Check the release is gone
helm list

# Clean up chart packages
rm -f mychart-*.tgz
rm -rf mychart/
```

## Challenge

1. Create a Helm chart for a simple web application
2. Add an Ingress resource to the chart
3. Use Helm values to configure different environments (dev, staging, prod)
4. Install a chart from a different repository (e.g., Prometheus, Grafana)

## Next Step

When done, proceed to [Step 11: Networking & Ingress](../11-networking-ingress/)
