# Step 14: Advanced Patterns - Operators, CRDs & More

## Overview

This step covers advanced Kubernetes patterns that go beyond basic deployments.

## Custom Resource Definitions (CRDs)

CRDs extend Kubernetes API with custom resources.

### CRD YAML

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: crontabs.stable.example.com
spec:
  group: stable.example.com
  versions:
  - name: v1
    served: true
    storage: true
    schema:
      openAPIV3Schema:
        type: object
        properties:
          spec:
            type: object
            properties:
              cronSpec:
                type: string
              image:
                type: string
              replicas:
                type: integer
  scope: Namespaced
  names:
    plural: crontabs
    singular: crontab
    kind: CronTab
    shortNames:
    - ct
```

### Custom Resource YAML

```yaml
apiVersion: stable.example.com/v1
kind: CronTab
metadata:
  name: my-crontab
spec:
  cronSpec: "* * * * */5"
  image: my-app
  replicas: 3
```

## Operators

Operators are software extensions that use custom resources to manage applications and their components.

### Operator Pattern

```
┌─────────────────────────────────────────────────────────┐
│                    Operator Pattern                      │
│                                                          │
│  ┌─────────────────────────────────────────────────┐   │
│  │                Reconciliation Loop               │   │
│  │                                                  │   │
│  │  ┌─────────┐     ┌─────────┐     ┌─────────┐   │   │
│  │  │ Desired │────▶│ Compare │────▶│ Act     │   │   │
│  │  │ State   │     │ State   │     │         │   │   │
│  │  └─────────┘     └─────────┘     └─────────┘   │   │
│  │       │                              │          │   │
│  │       └──────────────────────────────┘          │   │
│  │              (Continuous Loop)                   │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

### Operator Lifecycle

1. **Watch**: Monitor custom resources
2. **Compare**: Desired state vs current state
3. **Act**: Create/update/delete resources
4. **Repeat**: Continuous reconciliation

## Advanced Patterns

### 1. Sidecar Pattern
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sidecar-demo
spec:
  containers:
  - name: main-app
    image: my-app
  - name: sidecar
    image: log-shipper
    volumeMounts:
    - name: logs
      mountPath: /var/log
  volumes:
  - name: logs
    emptyDir: {}
```

### 2. Ambassador Pattern
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ambassador-demo
spec:
  containers:
  - name: main-app
    image: my-app
    ports:
    - containerPort: 8080
  - name: ambassador
    image: ambassador
    ports:
    - containerPort: 80
    env:
    - name: SERVICE_HOST
      value: "my-service"
    - name: SERVICE_PORT
      value: "3306"
```

### 3. Init Container Pattern
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: init-pattern-demo
spec:
  initContainers:
  - name: init-service
    image: busybox
    command: ['sh', '-c', 'until nslookup my-service; do sleep 2; done']
  containers:
  - name: main-app
    image: my-app
```

## StatefulSets

StatefulSets manage stateful applications.

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  serviceName: "nginx"
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
        ports:
        - containerPort: 80
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 1Gi
```

## Jobs and CronJobs

### Job
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: my-job
spec:
  completions: 3
  parallelism: 2
  template:
    spec:
      containers:
      - name: worker
        image: my-worker
      restartPolicy: Never
```

### CronJob
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: my-cronjob
spec:
  schedule: "0 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: worker
            image: my-worker
          restartPolicy: OnFailure
```

## Labs

See [labs/LAB.md](labs/LAB.md) for hands-on exercises.

## Demos

See [demos/](demos/) for working examples.
