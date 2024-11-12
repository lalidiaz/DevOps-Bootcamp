# Challenge-flask-k8s

This example creates a basic API with Flask, along with a consumer that accesses the API through the service. To expose the API, a NodePort service was created, which opens a port on all nodes so that the API is accessible from outside the cluster and by the consumer from the node.

## Repository
Check out the Kubernetes challenge https://github.com/roxsross/k8sonfire/tree/master/challenge-final/src

## Requirements
- Kubernetes Cluster (EKS, Minikube, K3s, etc.)
- Alternative: Killercoda
- Docker
- kubectl

## Challenge
1. Create the Dockerfiles for the application and the consumer.
    - The application’s Dockerfile should contain the necessary instructions to build the Flask API image.
    - The consumer’s Dockerfile should contain the instructions needed to build the image for the consumer that will access the API.
2. Build the application and consumer images.
    - Use the docker build command to build the images.
3. Push the images to Docker Hub.
    - Use the docker push command to upload the images to a Docker Hub repository.
4. Create the Kubernetes manifests based on the diagram analysis.
    - Namespace: Initial_firstname_lastname
    - NodePort type service
    - Create a Deployment for the Flask application.
    - Create a Deployment for the consumer.
    - Create a NodePort Service to expose the Flask API.
5. Apply the manifests in the EKS cluster.
    - Use the kubectl apply command to apply the manifests.

## Tips:
- The application runs on port `8000`.
- The consumer needs to access `http://service-flask-app`.

## Include an image of the results
Take a screenshot of the application and consumer working correctly.

## Live Classes
Deploy the challenge live and perform a live demonstration of the challenge deployment.


# My Solution ✅