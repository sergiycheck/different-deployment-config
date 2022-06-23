#!/bin/sh

kubectl() {
    /usr/local/bin/minikube kubectl -- "$@"
}
export kubectl

# minikube version
# kubectl version

# cluster details
# kubectl cluster-info
# kubectl get nodes

# deploy app
# kubectl create deployment kubernetes-bootcamp \
# --image=gcr.io/google-samples/kubernetes-bootcamp:v1
# kubectl get deployments

# open a second terminal window to run the proxy to access pods
# echo -e "\n\n\n\e[92mStarting Proxy. After starting it \
# will not output a response. Please click the first Terminal Tab\n"; 
# kubectl proxy
# curl http://localhost:8001/version

# export POD_NAME=$(kubectl get pods \
# -o go-template \
# --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
pod_name_str='kubernetes-bootcamp-d9b4bdd78-4zv4z '
# echo Name of the Pod: $POD_NAME

# access the pod
# curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/

# in order for the new deployment to be accessible without using
# the proxy a service is required which will be explained 
# in the next modules.


# exploring your app
# get existing pods
# kubectl get pods

# what containers are inside pod
# kubectl describe pods

# curl http://localhost:8001/api/v1/namespaces/default/pods/$pod_name_str/proxy/
# kubectl logs $pod_name_str # we don't need to speicfy the container name
# we have only one cotainer inside the pod

# executing command on the container
# kubectl exec $pod_name_str -- env
# kubectl exec -ti $pod_name_str -- bash

# services match a set of Pods using labels and selectors
# kubectl get services
# kubectl expose deployment/kubernetes-bootcamp \
# --type="NodePort" --port 8080

# kubectl describe services/kubernetes-bootcamp

export NODE_PORT=$(kubectl get services/kubernetes-bootcamp \
-o go-template='{{(index .spec.ports 0).nodePort}}')
# echo NODE_PORT=$NODE_PORT
# NODE_PORT='31993' this value is changable

# Now we can test that the app is exposed outside of the
# cluster using curl, the IP of the Node and the externally exposed port:
# curl $(minikube ip):$NODE_PORT
# 192.168.49.2:31993
# output: Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-d9b4bdd78-4zv4z | v=1

# using labels
# kubectl describe deployment
# kubectl get pods -l app=kubernetes-bootcamp
# kubectl get services -l app=kubernetes-bootcamp
# export POD_NAME=$(kubectl get pods -o go-template \
# --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
# echo Name of the Pod: $POD_NAME
# apply a new label
# kubectl label pods $pod_name_str version=v1
# kubectl describe pods $pod_name_str
# kubectl get pods -l version=v1

#deleting a sevice
# kubectl delete service -l app=kubernetes-bootcamp
# after service deletion app is not reachable from outside of the cluster
# kubectl exec -ti $pod_name_str -- curl localhost:8080
# output: Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-d9b4bdd78-4zv4z | v=1
# to shutdown  the app you would need to delete the deployment as well

# we created a deployment ad exposed it publicly via a service
# scaling a deployment
# kubectl get deployments
# kubectl get rs
# kubectl scale deployments/kubernetes-bootcamp --replicas=2
# check if the number of pods changed
# kubectl get pods -o wide
# kubectl describe deployments/kubernetes-bootcamp
# kubectl describe services/kubernetes-bootcamp
# we hit a different pod with every request. this demonstrates that the load-balancing is working
# curl $(minikube ip):$NODE_PORT

# performing a rolling update
# perform a rolling update using kubectl

# updating your app
# kubectl get deployments
# kubectl get pods
# kubectl describe pods
# update the image of the app to version 2
# kubectl set image deployments/kubernetes-bootcamp \
# kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2
# deployment.apps/kubernetes-bootcamp image updated
# kubectl get pods # update was not instant
# verify an update
# kubectl describe services/kubernetes-bootcamp
# You can also confirm the update by running the rollout status command:
# kubectl rollout status deployments/kubernetes-bootcamp
# rollback an another update
# kubectl set image deployments/kubernetes-bootcamp \
# kubernetes-bootcamp=gcr.io/google-samples/kubernetes-bootcamp:v10
# kubectl get deployments
# to roll back the deployment to your last working version, use the rollout undo command
# kubectl rollout undo deployments/kubernetes-bootcamp
# The rollout undo command reverts the deployment to the previous known state (v2 of the image)
# updates are versioned and you can revert to any previously known state of a deployment
# kubectl get pods