# Example: MySQL and PHPMyAdmin with Docker

This example shows how to run MySQL and PHPMyAdmin containers connected to each other, allowing you to easily manage a MySQL database through a graphical interface.

## Steps to Follow:

1. Start the MySQL Container:

Run the following command to start a MySQL container:

```
docker run --name=db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret-pw -d mysql:8.1
```

- `--name=db`: Assigns a name to the container (db in this case).
- `-p 3306:3306`: Maps port 3306 of the container to port 3306 on your local machine.
- `-e MYSQL_ROOT_PASSWORD=secret-pw`: Sets the password for the MySQL root user.
- `-d`: Runs the container in detached mode (background).

2. View MySQL Container Logs:

You can check the MySQL container logs to ensure it’s running correctly:

```
docker logs db
```

3. Connect to the MySQL Container:

To access the MySQL container terminal:

```
docker exec -it db bash
```

Once inside the container, you can connect to MySQL:

```
mysql -u root -p
```

Enter the password you specified earlier (secret-pw).

4. Exit the Container:

To exit the interactive MySQL terminal, type exit. Then, to leave the container without stopping it, press `Ctrl+P` and `Ctrl+Q`. This will return you to your local terminal without stopping the container.

5. Start the PHPMyAdmin Container:

Now, start a PHPMyAdmin container and link it to the MySQL container:

```
docker run -d --name=my-admin -p 82:80 --link db:db phpmyadmin:5.2.1
```

- `--name=my-admin`: Assigns a name to the PHPMyAdmin container.
- `-p 82:80`: Maps port 80 of the container to port 82 on your local machine.
- `--link db:db`: Links the PHPMyAdmin container to the MySQL container (db).

6. Access PHPMyAdmin:

Open your web browser and go to http://localhost:82/. Enter your MySQL credentials to access the PHPMyAdmin graphical interface and manage the database.

7. Stop and Remove the Containers:

Once you’re done using the containers, it's important to stop and remove them to free up resources:

```
docker stop db my-admin
docker rm db my-admin
```

- `docker stop`: Stops the specified containers.
- `docker rm`: Removes the stopped containers.

## Notes:

- Ensure that the ports you’re using (3306 for MySQL and 82 for PHPMyAdmin) are not in use by other services on your machine.
- PHPMyAdmin is a useful tool for managing MySQL databases without needing to use the command line, especially in development environments.

## My Solution ✅

1. Start the MySQL Container

```
docker run --name=db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret-pw -d mysql:8.1
```

2. View MySQL Container Logs:

```
docker logs db
```

<img width="952" alt="Screenshot 2024-10-20 at 7 25 23 PM" src="https://github.com/user-attachments/assets/df8947b0-dc93-4c80-864a-3e1d3b221617">

3. Connect to the MySQL Container:

```
docker exec -it db bash
mysql -u root -p
```

5. Start the PHPMyAdmin Container:

```
docker run -d --name=my-admin -p 82:80 --link db:db phpmyadmin:5.2.1
```

6. Access PHPMyAdmin:

Access `http://localhost:82/`
<img width="1465" alt="Screenshot 2024-10-20 at 7 27 36 PM" src="https://github.com/user-attachments/assets/6ecf3092-863b-41d8-aa24-91526a24347a">

7. Stop and Remove the Containers:

```
docker stop db my-admin
docker rm db my-admin
```

<img width="1144" alt="Screenshot 2024-10-20 at 7 29 19 PM" src="https://github.com/user-attachments/assets/dc80ee9d-a75a-42b9-ab10-036f139c4984">
