#!/usr/bin/env bash

# Get current path and build service location path
current_path=$(pwd)
service_path="$current_path/../kubernetes/services/local-service.yaml"

# Create the commands that will start minikube and create the service
minikube_start_command="minikube start --vm-driver=xhyve"
kubectl_create_service="kubectl create -f $service_path"

# Start minikube and create the services
eval $minikube_start_command
eval $kubectl_create_service