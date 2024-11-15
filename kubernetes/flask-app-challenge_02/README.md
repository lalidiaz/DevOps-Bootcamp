# Challenge-flask-k8s

![image](https://github.com/user-attachments/assets/fb3329fd-82c6-4bc3-b433-8d8a2f21dc87)

This example creates a basic API with Flask, along with a consumer that accesses the API through the service. To expose the API, a NodePort service was created, which opens a port on all nodes so that the API is accessible from outside the cluster and by the consumer from the node.

## Repository

Check out the Kubernetes challenge https://github.com/roxsross/k8sonfire/tree/master/challenge-final/src

## Requirements

- Kubernetes Cluster (EKS, Minikube, K3s, etc.)
- Alternative: Killercoda
- Docker
- kubectl

## Challenge

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
5. Apply the manifests in the Kubernetes cluster.
   - Use the kubectl apply command to apply the manifests.

## Tips:

- The application runs on port `8000`.
- The consumer needs to access `http://service-flask-app`.

## Include an image of the results
Take a screenshot of the application and consumer working correctly.

# My Solution ✅

1. Dockerfiles:

**/app/Dockerfile**

```
FROM python:alpine

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FLASK_APP=app.py

# Install build dependencies
RUN apk add --no-cache build-base

# Create a non-root user
RUN adduser --disabled-password --no-create-home appuser

# Copy requirements first to leverage Docker cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Set proper permissions
RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8000

CMD ["python", "app.py"]
```

**/consumer/Dockerfile**

```
# Use official Python slim image as base
FROM python:alpine

# Set working directory
WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create a non-root user for security
RUN adduser --disabled-password --no-create-home appuser

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY consumer.py .

# Set proper permissions
RUN chown -R appuser:appuser /app
USER appuser

# Run the consumer script
CMD ["python", "consumer.py"]
```

2. Build images

**Build the app image**

```
docker build -t lauradiazdev/flask-app:v1.0.0 .

```

**Build the consumer image**

```
docker build -t lauradiazdev/consumer:v1.0.0 .
```

3. Push the images to Docker Hub.

```
docker push lauradiazdev/flask-app:v1.0.0
docker push lauradiazdev/consumer:v1.0.0
```

```
app-flask image: lauradiazdev/flask-app:v1.0.0
consumer image: lauradiazdev/consumer:v1.0.0
```

4. Create the Kubernetes manifests based on the diagram analysis.

**Create namespace**

```
apiVersion: v1
kind: Namespace
metadata:
  name: initial-laura-diaz
```

**Create a Deployment for the Flask application**

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app
  namespace: initial-laura-diaz
spec:
  replicas: 1
  selector:
    matchLabels:
      app: flask-app
  template:
    metadata:
      labels:
        app: flask-app
    spec:
      containers:
        - name: flask-app
          image: lauradiazdev/flask-app:v1.0.0
          resources:
            requests:
              memory: "256Mi"
              cpu: "200m"
            limits:
              memory: "512Mi"
              cpu: "500m"
          imagePullPolicy: Always
          ports:
            - containerPort: 8000
```

**Service for Flask app**

```
apiVersion: v1
kind: Service
metadata:
  name: service-flask-app
  namespace: initial-laura-diaz
spec:
  type: NodePort
  selector:
    app: flask-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8000
      nodePort: 30000

```

**Create a Deployment for the consumer**

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: consumer
  namespace: initial-laura-diaz
  labels:
    app: consumer
    tier: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: consumer
      tier: frontend
  template:
    metadata:
      labels:
        app: consumer
        tier: frontend
    spec:
      containers:
        - name: consumer
          image: lauradiazdev/consumer:v1.0.0
          env:
            - name: SERVICE_URL
              value: "http://service-flask-app"
          resources:
            requests:
              memory: "128Mi"
              cpu: "250m"
            limits:
              memory: "128Mi"
              cpu: "256m"
```

5. Apply the manifests in Minikube

**Use the kubectl apply command to apply the manifests**

```
kubectl apply -f deployments/namespace.yaml
kubectl apply -f deployments/consumer-deployment.yaml
kubectl apply -f deployments/flask-service.yaml
kubectl apply -f deployments/flask-deployment.yaml
```


<img width="1573" alt="Screenshot 2024-11-15 at 3 22 52 PM" src="https://github.com/user-attachments/assets/f55df35f-95b0-4d22-8914-b32f776fba39">
<img width="1577" alt="Screenshot 2024-11-15 at 3 22 41 PM" src="https://github.com/user-attachments/assets/c55fc2f1-82b1-4365-ac37-ab834bf46f14">
<img width="1583" alt="Screenshot 2024-11-15 at 3 22 31 PM" src="https://github.com/user-attachments/assets/173c3416-84b2-4098-ac0b-efa54d30c84d">

