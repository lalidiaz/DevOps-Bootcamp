# Example: Configuring PostgreSQL with pgAdmin using Docker Compose

This example will guide you through deploying a PostgreSQL container and visualizing it with pgAdmin using Docker Compose to orchestrate the services.

## Step 1: Start the Services

Run the following command to build and start the containers in the background:

```
docker-compose up -d --build
```

Wait until both containers are ready.

## Step 2: Access pgAdmin

Once the containers are running, you can access pgAdmin through your browser at the following URL:

- URL: http://0.0.0.0:8080

Log in with the credentials defined in the docker-compose.yml file:

- Email: admin@example.com
- Password: secret123

## Step 3: Create a New Server in pgAdmin

To connect to your PostgreSQL container, create a new server in pgAdmin by following these steps:

1. Click on Add New Server.

2. Enter a name for the server, for example, My Postgres.

3. In the Connection tab, use the following credentials configured in the db service:

- **Hostname**: db (the service name in Docker Compose)
- **Username**: admin
- **Password**: secret123

Next, click **Save** to establish the connection.

Here are some screenshots to help guide you through this configuration:
![alt text](image.png)
![alt text](image-1.png)
![alt text](image-2.png)

## Step 4: Explore and Manage the Database

Once connected to the PostgreSQL server, you can start exploring and managing the database through pgAdmin's interface. If you want to create tables and manage data, I recommend following this additional guide:

- **Guide**: Creating and managing tables with pgAdmin

## Step 5: Stop and Clean Up the Containers

When you're done using the containers, it's important to stop and clean up the resources to avoid unnecessary consumption. Run the following command to stop and remove the containers, volumes, and downloaded images:

```
docker-compose down -v --rmi all
```

This command:

- Stops the containers.
- Removes the containers and created volumes.
- Deletes the images downloaded from the Docker registry.

This process ensures that your environment is clean after the session.

## My Solution ✅

My `docker-compose.yaml` file it's located in /docker/exercises directory.

Steps I followed to solve this exercise:

1. Get the official image for pgadmin from the docs: https://hub.docker.com/r/dpage/pgadmin4/
2. Check env. variables for the container from docs: https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html#environment-variables

<!-- In case I want to add volumes: 
Read about PGDATA for volumes in docs https://hub.docker.com/_/postgres:

#### PGDATA
`Important Note: when mounting a volume to /var/lib/postgresql, the /var/lib/postgresql/data path is a local volume from the container runtime, thus data is not persisted on the mounted volume.` -->

3. Create the `docker-compose.yaml` file

After successfully created the ```docker-compose.yaml file```, perform STEP 1:

```
docker compose up -d --build
```

<img width="1914" alt="Screenshot 2024-10-20 at 8 11 33 PM" src="https://github.com/user-attachments/assets/ae19da6d-7089-456e-9b4c-7a716153e5a2">

<img width="1909" alt="Screenshot 2024-10-20 at 8 12 28 PM" src="https://github.com/user-attachments/assets/531f24ef-5411-466c-99b5-ab82d7bd7b09">

<img width="1917" alt="Screenshot 2024-10-20 at 8 13 42 PM" src="https://github.com/user-attachments/assets/9138e1a2-0987-450c-9b4b-025a7e839b2f">


I can see the mydb database defined in docker-compose.yaml file: ```POSTGRES_DB: mydb```


<img width="358" alt="Screenshot 2024-10-20 at 8 15 19 PM" src="https://github.com/user-attachments/assets/ecd92d5d-64a7-4eda-8ff5-b48f562951e6">


4. Explore and Manage the Database

Create tables:

<img width="1184" alt="Screenshot 2024-10-20 at 8 18 09 PM" src="https://github.com/user-attachments/assets/e1be5db8-2dd4-4aab-9493-d713edfeacbc">

<img width="1095" alt="Screenshot 2024-10-20 at 8 21 03 PM" src="https://github.com/user-attachments/assets/baa02a7c-1053-4b43-b23a-6a45756fbefe">

<img width="1043" alt="Screenshot 2024-10-20 at 8 21 10 PM" src="https://github.com/user-attachments/assets/eea11f56-5701-458e-b73b-82297616eb60">

<img width="420" alt="Screenshot 2024-10-20 at 8 21 33 PM" src="https://github.com/user-attachments/assets/f496436f-b049-4e8c-9f80-1e22f022d6f1">


Add data to tables:


```INSERT SCRIPT```

<img width="562" alt="Screenshot 2024-10-20 at 8 26 24 PM" src="https://github.com/user-attachments/assets/e53d12dd-9e80-4486-abc9-021847257bc9">

<img width="1726" alt="Screenshot 2024-10-20 at 8 23 17 PM" src="https://github.com/user-attachments/assets/361b2d70-89fa-48db-be63-ab1ca11b8250">

<img width="828" alt="Screenshot 2024-10-20 at 8 32 15 PM" src="https://github.com/user-attachments/assets/5016a2e1-fd83-44eb-bf76-8fca54940859">


5. Stop and Clean Up the Containers

```
docker compose down -v --rmi all
```

<img width="1085" alt="Screenshot 2024-10-20 at 8 34 27 PM" src="https://github.com/user-attachments/assets/1491642b-b705-4f25-b78d-311716c64f52">

<img width="1088" alt="Screenshot 2024-10-20 at 8 35 02 PM" src="https://github.com/user-attachments/assets/501a0b93-0ccf-496d-9228-a2b25fa37c0b">
