#!/bin/bash

# Set the application name
APP_NAME="295words"

# Use semantic-release to get the version
VERSION=$(npx semantic-release --dry-run --branches main | grep -o -E 'v[0-9]+\.[0-9]+\.[0-9]+')

# Build the Docker images
echo "Building Docker images..."
docker build -t lauradiazdev/$APP_NAME:backend-$VERSION -f api/Dockerfile api/
docker build -t lauradiazdev/$APP_NAME:frontend-$VERSION -f web/Dockerfile web/
docker build -t lauradiazdev/$APP_NAME:db-$VERSION -f db/Dockerfile db/

# Push the Docker images to Docker Hub
echo "Pushing Docker images to Docker Hub..."
docker push lauradiazdev/$APP_NAME:backend-$VERSION
docker push lauradiazdev/$APP_NAME:frontend-$VERSION
docker push lauradiazdev/$APP_NAME:db-$VERSION

# Run Docker Compose with the versioned images
echo "Running Docker Compose..."
docker-compose up -d

echo "Deployment completed."