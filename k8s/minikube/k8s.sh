#!/bin/sh

# aliases are deprecated in favor of shell functions.
# https://askubuntu.com/questions/98782/how-to-run-an-alias-in-a-shell-script
kubectl() {
    /usr/local/bin/minikube kubectl -- "$@"
}
export kubectl

# You can also make your life easier by adding the following to your shell config:
# alias kubectl="minikube kubectl --"
# launch dashboard (first time is extremly slow)
# minikube dashboard
# kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4
# kubectl expose deployment hello-minikube --type=NodePort --port=8080
# get service info
# kubectl get services hello-minikube
#  launch a web browser for you
# minikube service hello-minikube
# could not access after it
# kubectl port-forward service/hello-minikube 7080:8080
# Your application is now available at http://localhost:7080/.


# loadbalancer deployments
# command kubectl create deployment balanced --image=k8s.gcr.io/echoserver:1.4
# kubectl expose deployment balanced --type=LoadBalancer --port=8080
# routable ip for the balanced deployment
# minikube tunnel
# to find the routable ip
# kubectl get services balanced

# manage your cluster
# minikube pause
# minikube unpause
# minikube start
# minikube stop
