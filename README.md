# The wordpress example application

This repository provide an example of how to deploy highly available wordpress with MySQL on kubernetes cluster.

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
3. Deploy wordpress application with MySQL database
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
