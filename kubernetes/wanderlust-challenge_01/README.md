# Project Overview - My Solution ✅

This project includes Docker and Kubernetes configurations for a full-stack application. The setup features both backend and frontend services, a Redis database, and a MongoDB instance.
Below, you’ll find details about the approach I took to optimize and deploy this application in a **Kubernetes** environment using Docker images, multi-stage builds, and a `docker-compose.yaml` setup.

## Docker Images

To optimize Docker images for both the backend and frontend, I implemented multi-stage builds. This approach reduced image sizes significantly, improving performance and reducing resource use:

**Frontend Dockerfile**: The frontend image uses a multi-stage build where the first stage builds the Vite app, and the second stage serves static files with an Nginx server. Multi-stage builds helped reduce the image size by separating the build environment from the final runtime environment.

```
# First stage: Build the app
FROM node:21-alpine AS builder

# Add labels for better maintainability and metadata
LABEL maintainer="Laura Diaz lauradiaz1586@gmail.com>"
LABEL description="Frontend WanderLust is a MERN travel blog website 🚀 This project is aimed to help people to contribute in open source, upskill in react and master git."
LABEL version="1.0"

WORKDIR /app

COPY package*.json ./

RUN npm install

# Copy the rest of the application code and build it
COPY . .

# Pass VITE_API_PATH environment variable during the build
ARG VITE_API_PATH
ENV VITE_API_PATH=$VITE_API_PATH

# Build the Vite app
RUN npm run build


# Second stage: Nginx server to serve static files
FROM nginx:alpine

# Copy the custom nginx.conf file from your project
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Copy built files from the builder stage to Nginx's static directory
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
```

**Backend Dockerfile**: I incorporate changes based on best practices, I create a non-root user for security, copy package files first to leverage cache, install curl for healthcheck and Switch to non-root user.

```
FROM node:21-alpine

# Add labels for better maintainability and metadata
LABEL maintainer="Laura Diaz lauradiaz1586@gmail.com>"
LABEL description="Backend WanderLust is a MERN travel blog website 🚀 This project is aimed to help people to contribute in open source, upskill in react and master git."
LABEL version="1.0"

# Install curl first (as root)
RUN apk add --no-cache curl

# Create a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy package files first to leverage cache
COPY package*.json ./


# install curl for healthcheck
RUN npm install && \
    npm cache clean --force

# Copy application code
COPY --chown=appuser:appgroup . .

# Switch to non-root user
USER appuser

EXPOSE 5000

CMD ["npm", "start"]
```

During this process, I ran into and solved issues with image configuration and compatibility in Kubernetes deployments, making sure everything worked smoothly in the target environment. I debugged by checking logs and connections in **k9s**.

## Docker Compose Setup

The `docker-compose.yaml` file defines a setup with four containers:

- Backend container (API)
- Frontend container (Vite)
- Redis container
- MongoDB container

To enhance resilience and error detection, I added health checks for MongoDB, Redis, and the backend containers. This ensures that Docker Compose can monitor service health and restart containers as needed.

```
services:
  backend:
    build: ./backend
    container_name: backend
    image: lauradiazdev/wandelust:backend-1.0.0
    environment:
      - MONGODB_URI=mongodb://mongodb/wanderlust
      - REDIS_URL=redis:6379
    ports:
      - 5000:5000
    depends_on:
      mongodb:
        condition: service_started
      redis:
        condition: service_started
    networks:
      - wanderlust_network
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s

  frontend:
    build:
      context: ./frontend
      args:
        VITE_API_PATH: http://localhost:5000
    container_name: frontend
    image: lauradiazdev/wandelust:frontend-1.0.0
    ports:
      - 80:80
    depends_on:
      - backend
    networks:
      - wanderlust_network

  mongodb:
    container_name: mongodb
    image: mongo
    volumes:
      - mongodb_data:/data
    ports:
      - 27017:27017
    networks:
      - wanderlust_network
    healthcheck:
      test: echo 'db.runCommand("ping").ok' | mongosh localhost:27017/test --quiet
      interval: 10s
      timeout: 10s
      retries: 5

  redis:
    container_name: redis
    image: redis:alpine
    ports:
      - 6379:6379
    networks:
      - wanderlust_network
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  mongodb_data:
    driver: local

networks:
  wanderlust_network:
    name: wanderlust_network
```

## Kubernetes Deployment

To deploy this project on Kubernetes, I created a directory structure as follows:

- /podinfo: Contains test cases for pods.
- /pod: Contains initial pod configurations for understanding Kubernetes basics.
- /deployment: Contains `deployment.yaml` and `service.yaml` files for each service.

Each deployment configuration was crafted to define individual services in Kubernetes, making scaling and maintenance straightforward.

## Minikube and Troubleshooting

I used Minikube to simulate the Kubernetes environment locally, creating a namespace called `development`. After applying the Kubernetes manifest files, I encountered an issue where the frontend couldn’t reach the backend. The problem was due to this line in `nginx.conf`:

```
proxy_pass http://localhost:5000;
```

In a Kubernetes environment, using localhost to connect services won’t work as each service runs in its own pod, with isolated networking. Instead, services in Kubernetes are accessed by their service name. Changing this line to:

```
proxy_pass http://backend:5000;
```

Resolved the issue, as it directed Nginx to reach the backend service by name.

## Docker Hub

Finally, I pushed all Docker images to Docker Hub for easier access and deployment in different environments.
