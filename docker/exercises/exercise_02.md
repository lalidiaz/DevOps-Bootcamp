# Example: MySQL with Docker

This example shows how to set up and manage a MySQL container using Docker. You will learn how to create a MySQL container, interact with the database, and persist data to ensure it is not lost when the container is stopped or removed.

## Steps to Follow:

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
SELECT * FROM users;
```

### Notes:

- Make sure the path /data/mysql-data on your local machine exists and has the appropriate permissions for Docker to write to it.
- This example assumes you have an SQL file you want to run in the database. If you don’t have one, you can manually create a table and add some data to test the persistence.


## My Solution ✅

1. Buld and run MySQL container, I modified the path from my local machine for it to work. 

```
docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=my-data-pass -v /Users/my_user/Desktop/mysql-data:/var/lib/mysql mysql
```

2. Access the MySQL container
   
```
docker exec -it mysql-container bash
```

Access MySQL client

```
mysql -u root -p
```

3. Run an SQL Script Inside the Container:

I created a ```data.sql``` file inside mysql-data directory with the following content:

```
-- Create a database
CREATE DATABASE IF NOT EXISTS sample_db;

-- Use the new database
USE sample_db;

-- Create a table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert some data into the table
INSERT INTO users (name, email) VALUES 
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com');

-- Select all records from the table
SELECT * FROM users;
```
Exit the container and copy the SQL script into the container (assuming my script is located at /Users/my_user/Desktop/data/mysql-data/data.sql on my host machine):

```
docker cp /Users/my_user/Desktop/data/mysql-data/data.sql mysql-container:/data.sql
```
<img width="487" alt="Screenshot 2024-10-20 at 6 57 08 PM" src="https://github.com/user-attachments/assets/d82dbff5-ac6c-42aa-8070-8b6619bc0f30">


Run the SQL Script

```
docker exec -it mysql-container bash
mysql -u root -p
SOURCE /data.sql;
```

<img width="758" alt="Screenshot 2024-10-20 at 6 42 03 PM" src="https://github.com/user-attachments/assets/0267f233-e3b7-4a77-b089-7d94ad6ed0f0">


4. Stop and Remove the MySQL Container:

<img width="724" alt="Screenshot 2024-10-20 at 7 00 45 PM" src="https://github.com/user-attachments/assets/8825426a-f875-44bc-b566-c584384a3ab2">


5. Restart the MySQL Container:

```
docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=my-data-pass -v /Users/my_user/Desktop/mysql-data:/var/lib/mysql mysql
```


6. Verify Data Persistence:


Access the container again and check that the previous data is still in the database:

```
docker exec -it mysql-container bash
```

Inside the container: 
```
mysql -u root -p
USE sample_db;
SELECT * FROM usuarios;
```

<img width="787" alt="Screenshot 2024-10-20 at 7 06 13 PM" src="https://github.com/user-attachments/assets/8d86e20d-6c6b-4c0b-bcf2-7ae5bb3acc10">


