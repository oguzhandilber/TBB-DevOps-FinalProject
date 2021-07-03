#!/bin/bash

echo "Creating the Namespace..."
kubectl apply -f create-ns.yaml

echo "Creating the volume..."
kubectl apply -f mysql-pv.yaml

echo "Creating the Database credentials..."
kubectl apply -f flaskapi-secrets.yaml

echo "Creating the mysql deployment and service..."
kubectl apply -f mysql-deployment.yaml

echo "Creating the flask deployment and service..."
kubectl apply -f flaskapp-deployment.yaml

echo "Flask app created in the specified Namespace"
