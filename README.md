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

2. Build docker image. (optional)
```
export registry=<registry/imagename>
export tag=<tag>
docker build -t ${registry}:${tag} .
docker push ${registry}:${tag}
```

3. Install the nginx ingress controller. Please see the [installation guild](https://kubernetes.github.io/ingress-nginx/deploy/) for other kubernetes platforms. 
```
#Example for GKE
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.48.1/deploy/static/provider/cloud/deploy.yaml
```

4. Deploy wordpress application with MySQL database
- Go to deployment directory
```
cd deployment
```

- Set DBNAME, DBUSERNAME, DBPASSWORD and DBROOTPASSWORD on kustomization.yaml
```
cat <<EOF > kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
secretGenerator:
- name: mysql-pass
  literals:
    - databaseName=<DBNAME>
    - username=<DBUSERNAME>
    - password=<DBPASSWORD>
- name: mysql-root-pass
  literals:
  - password=<DBROOTPASSWORD>
resources:
  - namespace.yaml
  - mysql-configmap.yaml
  - mysql-service.yaml
  - mysql-statefulset.yaml
  - wordpress-deployment.yaml
  - wordpress-ingress.yaml
  - wordpress-nfsserver.yaml
namespace: wordpress-namespace
EOF
```
- Apply all manifest files using Kustomize. 
```
kubectl apply -k ./
```
The result from previous command 
```
namespace/wordpress-namespace created
configmap/mysql created
secret/mysql-pass-t95t696569 created
secret/mysql-root-pass-2ht65724t5 created
service/mysql created
service/nfs-server created
service/wordpress-svc created
persistentvolume/wordpress-nfs created
persistentvolumeclaim/nfs created
persistentvolumeclaim/wordpress-nfs created
deployment.apps/wordpress created
statefulset.apps/mysql created
ingress.networking.k8s.io/ingress created
replicationcontroller/nfs-server created
```

- Verify pods status and wait until all pods status change to "Running".
```
watch kubectl get pod -n wordpress-namespace
```
- The ingress loadbalancer IP will show up. (This process can take 2-3 minutes)
```
kubectl get ingress -n wordpress-namespace
```
```
NAME      CLASS    HOSTS   ADDRESS          PORTS     AGE
ingress   <none>   *       35.198.218.114   80, 443   31m
```
- The application should be able to access via https://35.198.218.114
![image](https://user-images.githubusercontent.com/74763224/128417930-5b4198d3-79b3-40ef-a372-38895a6bf614.png)

