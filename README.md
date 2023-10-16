## K8S Minikube example

Test application with K8S and minikube

### Prerequisites

Install [k8s](https://kubernetes.io/releases/download/) and [tools](https://kubernetes.io/docs/tasks/tools/)

### How to

1) Start minikube with VB driver:
```
minikube config set driver virtualbox
minikube start --nodes 2 -p web-tech
minikube config set profile web-tech
```

2) Prepare docker image:
```
docker build . -f Dockerfile -t web-dev
minikube cache add web-dev
# or minikube image load web-dev
```

3) Start PostgreSQL:
```
minikube kubectl -- apply -f k8s/postgres-config-map.yml
minikube kubectl -- apply -f k8s/postgres-secret.yml
minikube kubectl -- apply -f k8s/postgres-persistent-volume.yml
minikube kubectl -- apply -f k8s/postgres-persistent-volume-claim.yml
minikube kubectl -- apply -f k8s/postgres-deployment.yml
minikube kubectl -- apply -f k8s/postgres-service.yml

kubectl get pods
kubectl exec -it <<POSTGRES_POD_NAME>> -- bash
psql -U vehicle_quotes
\l
# you will see list of databases
# exit
```

4) Start WebApp:
```
minikube kubectl -- apply -f k8s/web-deployment.yml
minikube kubectl -- apply -f k8s/web-service.yml

# wait till migrations finish (check logs for details)

kubectl get pods
kubectl exec -it <<WEBAPP_POD_NAME>> -- bash
# exit

minikube kubectl -- get svc
minikube service webapp-service
# follow to ip with port
```
