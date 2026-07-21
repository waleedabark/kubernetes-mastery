# Step 06: Services - Networking Your Pods

## What is a Service?

A Service is an abstraction that defines a logical set of Pods and a policy by which to access them. Services enable communication between different parts of your application.

## Why Services?

- **Stable IP**: Pods get temporary IPs; Services provide a stable endpoint
- **Load Balancing**: Distribute traffic across multiple pods
- **Service Discovery**: Find other services by name
- **External Access**: Expose applications to the internet

## Service Types

### 1. ClusterIP (Default)
- Internal access only within the cluster
- Perfect for microservice-to-microservice communication

```
┌─────────────────────────────────────────┐
│              Cluster                    │
│                                         │
│  ┌─────────┐    ┌──────────────────┐   │
│  │ Service │───▶│ Pod1, Pod2, Pod3 │   │
│  │(10.0.0. │    └──────────────────┘   │
│  │   5)    │                            │
│  └─────────┘    ┌──────────────────┐   │
│       │         │ Pod1, Pod2, Pod3 │   │
│       └────────▶└──────────────────┘   │
└─────────────────────────────────────────┘
```

### 2. NodePort
- Exposes service on each node's IP at a static port
- External access via `<NodeIP>:<NodePort>`

```
┌──────────────────────────────────────────────────┐
│                    Cluster                        │
│                                                  │
│  ┌─────────┐                                     │
│  │ Service │───▶┌──────────────────┐            │
│  │(NodePort│    │ Pod1, Pod2, Pod3 │            │
│  │ :30000) │    └──────────────────┘            │
│  └─────────┘                                     │
│       ▲                                          │
└───────┼──────────────────────────────────────────┘
        │
┌───────┼──────────────────────────────────────────┐
│       │         External Traffic                 │
│   ┌───┴───┐                                      │
│   │ Node  │                                      │
│   │ :30000│                                      │
│   └───────┘                                      │
└──────────────────────────────────────────────────┘
```

### 3. LoadBalancer
- Exposes service externally using cloud provider's load balancer
- Automatically creates external IP

### 4. ExternalName
- Maps a service to an external DNS name
- No proxying involved

## Service YAML Structure

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: ClusterIP  # or NodePort, LoadBalancer, ExternalName
  selector:
    app: my-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
    nodePort: 30080  # Only for NodePort type
```

## Service Discovery

### 1. Environment Variables
```bash
# When a service 'my-service' is created, pods get:
MY_SERVICE_HOST=10.0.0.5
MY_SERVICE_PORT=80
```

### 2. DNS
```bash
# Pods can reach services via DNS:
my-service                    # Same namespace
my-service.namespace          # Specific namespace
my-service.namespace.svc      # Full DNS name
```

## Common Commands

```bash
# Create a service
kubectl apply -f service.yaml

# List services
kubectl get svc

# Describe a service
kubectl describe svc my-service

# Check endpoints
kubectl get endpoints my-service

# Delete a service
kubectl delete svc my-service
```

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
