#!/bin/bash

echo "Enter the Namespace you want to deploy: (dev,test or prod)"  
read environment

echo "Deploying project to $environment Namespace"

echo "Creating the Namespace..."
kubectl apply -f ./KubernetesYamls/$environment/create-ns.yaml

echo "Creating the volume..."
kubectl apply -f ./KubernetesYamls/$environment/mysql-pv.yaml

echo "Creating the Database credentials..."
kubectl apply -f ./KubernetesYamls/$environment/flaskapi-secrets.yaml

echo "Creating the mysql deployment and service..."
kubectl apply -f ./KubernetesYamls/$environment/mysql-deployment.yaml

echo "Creating the flask deployment and service..."
kubectl apply -f ./KubernetesYamls/$environment/flaskapp-deployment.yaml

echo "Configuring MySQL database..."
kubectl run -it -n $environment --rm --image=mysql --restart=Never mysql-client -- mysql --host mysql --password=123456 -e "CREATE DATABASE IF NOT EXISTS flaskapi;USE flaskapi;CREATE TABLE IF NOT EXISTS users(user_id INT PRIMARY KEY AUTO_INCREMENT, user_name VARCHAR(255), user_email VARCHAR(255), user_password VARCHAR(255));INSERT INTO users(user_name, user_email, user_password ) VALUES ('oguzhan', 'k8s48@gmail.com', '123456');"

echo "Flask app created in the specified Namespace successfully!"
