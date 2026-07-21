# Step 07: ConfigMaps & Secrets

## Overview

Kubernetes separates configuration from container images using ConfigMaps and Secrets. This follows the Twelve-Factor App methodology.

## ConfigMaps

ConfigMaps store non-confidential configuration data as key-value pairs.

### Use Cases
- Environment variables
- Command-line arguments
- Configuration files
- Properties files

### ConfigMap YAML Structure

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap
data:
  # Simple key-value pairs
  APP_ENV: "production"
  APP_DEBUG: "false"
  
  # Configuration file
  application.properties: |
    database.host=mysql-service
    database.port=3306
    cache.ttl=3600
  
  # JSON data
  config.json: |
    {
      "logging": {
        "level": "info",
        "format": "json"
      }
    }
```

### Using ConfigMaps

#### 1. Environment Variables
```yaml
spec:
  containers:
  - name: app
    envFrom:
    - configMapRef:
        name: my-configmap
```

#### 2. Single Environment Variable
```yaml
spec:
  containers:
  - name: app
    env:
    - name: APP_ENV
      valueFrom:
        configMapKeyRef:
          name: my-configmap
          key: APP_ENV
```

#### 3. Volume Mount
```yaml
spec:
  containers:
  - name: app
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config
  volumes:
  - name: config-volume
    configMap:
      name: my-configmap
```

## Secrets

Secrets store sensitive data like passwords, tokens, and keys. They are base64 encoded (NOT encrypted by default).

### Secret Types

| Type | Description |
|------|-------------|
| `Opaque` | Default type, arbitrary user-defined data |
| `kubernetes.io/tls` | TLS certificate and key |
| `kubernetes.io/dockerconfigjson` | Docker registry credentials |
| `kubernetes.io/basic-auth` | Basic authentication |
| `kubernetes.io/ssh-auth` | SSH authentication |

### Secret YAML Structure

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  # Base64 encoded values
  username: YWRtaW4=      # echo -n 'admin' | base64
  password: cEBzc3cwcmQ=  # echo -n 'p@ssw0rd' | base64
```

### Using Secrets

#### 1. Environment Variables
```yaml
spec:
  containers:
  - name: app
    envFrom:
    - secretRef:
        name: my-secret
```

#### 2. Volume Mount
```yaml
spec:
  containers:
  - name: app
    volumeMounts:
    - name: secret-volume
      mountPath: /etc/secrets
  volumes:
  - name: secret-volume
    secret:
      secretName: my-secret
```

## Best Practices

1. **Don't commit secrets to Git**
2. **Use external secret stores** (Vault, AWS Secrets Manager)
3. **Enable encryption at rest** for etcd
4. **Use RBAC** to limit secret access
5. **Rotate secrets regularly**

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
