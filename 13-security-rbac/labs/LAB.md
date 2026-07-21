# Lab 13: Security & RBAC

## Prerequisites
- Kubernetes cluster running
- kubectl configured

## Lab 1: Create a Service Account

```bash
# Create a service account
kubectl create serviceaccount my-sa

# Check the service account
kubectl get sa my-sa

# Describe the service account
kubectl describe sa my-sa
```

## Lab 2: Create a Role

```bash
# Apply a role
kubectl apply -f ../demos/01-role.yaml

# Check the role
kubectl get roles

# Describe the role
kubectl describe role pod-reader
```

## Lab 3: Create a RoleBinding

```bash
# Apply a role binding
kubectl apply -f ../demos/02-rolebinding.yaml

# Check the role binding
kubectl get rolebindings

# Describe the role binding
kubectl describe rolebinding read-pods
```

## Lab 4: Test RBAC

```bash
# Test with kubectl auth
kubectl auth can-i get pods --as=system:serviceaccount:default:my-sa
kubectl auth can-i delete pods --as=system:serviceaccount:default:my-sa
kubectl auth can-i list deployments --as=system:serviceaccount:default:my-sa
```

## Lab 5: Pod Security

```bash
# Apply a pod with security context
kubectl apply -f ../demos/03-pod-security.yaml

# Check the pod
kubectl get pods

# Verify the pod is running as non-root
kubectl exec -it secure-pod -- id

# Check the security context
kubectl get pod secure-pod -o yaml | grep -A 10 "securityContext"
```

## Lab 6: Network Policy

```bash
# Apply a default deny policy
kubectl apply -f ../demos/04-network-policy.yaml

# Check the policy
kubectl get networkpolicies

# Apply a policy to allow specific traffic
kubectl apply -f ../demos/05-allow-specific.yaml
```

## Cleanup

```bash
kubectl delete sa --all
kubectl delete roles --all
kubectl delete rolebindings --all
kubectl delete networkpolicies --all
kubectl delete pod --all
```

## Next Step

When done, proceed to [Step 14: Advanced Patterns](../14-advanced-patterns/)
