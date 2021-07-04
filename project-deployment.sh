#!/bin/bash

echo "Creating the Namespace..."
kubectl apply -f ./KubernetesYamls/dev/create-ns.yaml

echo "Creating the volume..."
kubectl apply -f ./KubernetesYamls/dev/mysql-pv.yaml

echo "Creating the Database credentials..."
kubectl apply -f ./KubernetesYamls/dev/flaskapi-secrets.yaml

echo "Creating the mysql deployment and service..."
kubectl apply -f ./KubernetesYamls/dev/mysql-deployment.yaml

echo "Creating the flask deployment and service..."
kubectl apply -f ./KubernetesYamls/dev/flaskapp-deployment.yaml

echo "Configuring MySQL database..."
kubectl run -it --rm --image=mysql --restart=Never mysql-client -- mysql --host mysql --password=123456 -e "CREATE DATABASE IF NOT EXISTS flaskapi;USE flaskapi;INSERT INTO users(user_name, user_email, user_password ) VALUES ('oguzhan', 'k8s48@gmail.com', '123456');"

echo "Flask app created in the specified Namespace successfully!"
