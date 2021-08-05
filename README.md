# High Availability Wordpress with MySQL on Kubernetes

This repository provide an example of how to deploy highly available wordpress with MySQL database on kubernetes cluster.

- High availability Wordpress application
- NFS storage for Wordpress application
- MySQL replication cluster
- Kubernetes-based load balancers and service networking

### Requirement
- Kubernetes cluster
- Docker (optional)

### Deploy the application
1. Clone the repository 
```
git clone https://github.com/nunjtn/wordpress-mysql.git
```
2. Build docker image (optional)
```
export registry=<registryname>
export tag=<tag>
docker build -t ${registry}:${tag} .
docker push ${registry}:${tag}
```
3. Install the nginx ingress controller
```
https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.48.1/deploy/static/provider/cloud/deploy.yaml
```

4. Deploy wordpress application with MySQL database
```
.
├── deployment
│   ├── kustomization.yaml
│   ├── mysql-configmap.yaml
│   ├── mysql-service.yaml
│   ├── mysql-statefulset.yaml
│   ├── wordpress-deployment.yaml
│   ├── wordpress-ingress.yaml
│   └── wordpress-nfsserver.yaml
├── Dockerfile
├── README.md
└── wp-content

```
