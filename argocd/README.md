# ArgoCD Integration for Budget App

This directory contains configuration files for deploying the Budget App using ArgoCD.

## Installation

1. Install ArgoCD in your Kubernetes cluster:

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

2. Access the ArgoCD UI:

```bash
# Port forwarding
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Get the initial admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

3. Apply the application manifest:

```bash
kubectl apply -f argocd/application.yaml
```

## Configuration

- Update the `application.yaml` file with your actual Git repository URL
- ArgoCD will automatically sync changes from your Git repository to the Kubernetes cluster
- The application is configured to auto-sync and self-heal