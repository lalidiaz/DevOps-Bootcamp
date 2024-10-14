# Example: MySQL with Docker

This example shows how to set up and manage a MySQL container using Docker. You will learn how to create a MySQL container, interact with the database, and persist data to ensure it is not lost when the container is stopped or removed.

## Steps to Follow:

1. Build and Run a MySQL Container:
   This command creates a MySQL container with a specified root password and a volume that persists the data on your local machine.

```
docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=my-data-pass -v /data/mysql-data:/var/lib/mysql mysql
```

- `-d`: Runs the container in detached mode.
- `--name mysql-container`: Assigns a name to the container.
- `-e MYSQL_ROOT_PASSWORD=my-data-pass:` Sets the password for the MySQL root user.
- `-v /data/mysql-data:/var/lib/mysql:` Mounts a local volume to persist the database data.

2. Access MySQL Inside the Container:

Once the container is running, you can access its terminal and run commands in MySQL.

```
docker exec -it mysql-container bash
```

Inside the container, enter the MySQL client with the following command:

```
mysql -u root -p
```

Enter the password you specified when creating the container (`my-data-pass`).

3. Run an SQL Script Inside the Container:

To execute an SQL file (e.g., data.sql) that is located on your local machine, you must copy it to the container or mount it as a volume.

```
mysql -u root -p
USE database_name;
SOURCE /path/to/file/data.sql;
```

4. Stop and Remove the MySQL Container:

If you need to temporarily stop the container, use the following command:

```
docker stop mysql-container
```

To remove the container:

```
docker rm mysql-container
```

5. Restart the MySQL Container:

Run the container again using the same command as before. The data will persist thanks to the mounted volume.

```
docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=my-data-pass -v /data/mysql-data:/var/lib/mysql mysql
```

6. Verify Data Persistence:

Access the container again and check that the previous data is still in the database:

```
docker exec -it mysql-container bash
```

Inside the container:

```
mysql -u root -p
USE database_name;
SELECT \* FROM users;
```

### Notes:

Make sure the path /data/mysql-data on your local machine exists and has the appropriate permissions for Docker to write to it.
This example assumes you have an SQL file you want to run in the database. If you don’t have one, you can manually create a table and add some data to test the persistence.
