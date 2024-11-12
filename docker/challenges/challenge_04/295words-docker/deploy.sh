#!/bin/bash

# Set the application name
APP_NAME="295words"

# Get the latest Git tag and use it as the version
VERSION=$(git describe --tags --abbrev=0)

# Debugging: Print the version to check if it's being extracted correctly
echo "Detected version: $VERSION"

# Check if the version is empty
if [ -z "$VERSION" ]; then
    echo "Error: No version found. Aborting deployment."
    exit 1
fi

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
