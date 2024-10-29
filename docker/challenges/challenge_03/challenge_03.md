# Deployment of the "295topics" Application with Docker and Docker Compose

## Challenge Description:

This challenge focuses on configuring and deploying the "295topics" application, which consists of a frontend in Node.js, a backend in TypeScript, and a MongoDB database, using Docker containers and Docker Compose.

The goal is to ensure that the application is scalable, easy to manage, and efficiently deployed.

### Architecture:

You will apply your DevOps skills to containerize and manage the "295topics" application. This application consists of three main components:

- **Frontend in Node.js and Express**:
  It will serve web content on port 3000. You need to create a Dockerfile for the frontend, build the image, and publish it on Docker Hub.

- **Backend in TypeScript**:
  It will run on port 5000 and connect to a MongoDB database. You need to create a Dockerfile for the backend, build the image, and publish it on Docker Hub.

- **MongoDB Database**:
  It will be deployed through a MongoDB container. You will also need to configure a mongo-init.js file to load initial data into the database when the container starts.

![image](https://github.com/user-attachments/assets/0b1229c0-330a-4863-855a-2df28e74f439)

### Requirements:

#### Environment Setup

Clone the challenge repository:

```
git clone -b ejercicio2-dockeriza https://github.com/roxsross/bootcamp-devops-2023.git
cd 295topics-fullstack
```

#### Frontend in Node.js and Express

- **Configuration**: The frontend source code uses port 3000 to expose the application.

- **Dockerfile**: Create a Dockerfile that includes all necessary dependencies and sets the start command.

- **Build and Publish**: Build the frontend image and publish it to Docker Hub.

- **Backend Connection**: Ensure the frontend consumes the backend endpoint via the API_URI variable:

```
API_URI=http://topics-api:5000/api/topics
```

- Testing: Verify the frontend by accessing http://localhost:3000. Check the logs to troubleshoot any issues.

#### Backend in TypeScript

- **Configuration**: The backend source code uses port 5000 and connects to a MongoDB database.

- **Dockerfile**: Create a Dockerfile that includes all necessary dependencies and sets the start command.

- **Environment Variables**: Ensure the following environment variables are set in the Dockerfile or configuration file:

```
DATABASE_URL=mongodb://<your-mongo-container>:27017
DATABASE_NAME=TopicstoreDb
HOST=0.0.0.0
PORT=5000
```

- **Build and Publish**: Build the backend image and publish it to Docker Hub.

- **Testing**: Verify the backend by accessing http://localhost:5000/api/topics. Check the logs for potential errors.

#### MongoDB Database

- **Initial Configuration**: Use the mongo-init.js file to preload data into the MongoDB database when the container starts.

- **Container Setup**: Set up a Docker container for MongoDB and use the mongo-init.js file for initialization.

- **Testing**: Verify that the data has been loaded correctly by connecting to the MongoDB container:

```
docker exec -it <mongo-container-name> mongosh
> use TopicstoreDb
> db.Topics.find()
```

#### Mongo Express

**Configuration**: Set up a Docker container for Mongo Express and ensure it is properly connected to the MongoDB database for management.

#### Docker Compose

- **Service Configuration**: Create a docker-compose.yml file that defines the services for the frontend, backend, MongoDB, and Mongo Express.
- **Service Dependencies**: Ensure the proper dependencies are set so that services start in the correct order.
- **Testing**: Verify the application works by running docker-compose up and accessing the corresponding services.

#### Additional Challenge

- **Deployment Automation**: Create a Bash script to automate the deployment of the application in a production environment.

#### Evaluation Criteria

1. Correct configuration of services in the docker-compose.yml file.
2. Successful data preloading in MongoDB using mongo-init.js.
3. Correct exposure of ports for the frontend and backend.
4. Successful connection between the frontend and backend via Docker Compose.
5. Functional configuration of Mongo Express for database management.
6. Clear documentation and organization of the source code.
7. Successful deployment on a cloud server (if the additional challenge is completed).
8. Deployment automation (if the additional challenge is completed)

#### Achievements

This challenge provides a comprehensive hands-on experience in DevOps, covering container image creation, service orchestration, and database management, enabling you to efficiently deploy and manage the "295topics" application.

## My Solution ✅
