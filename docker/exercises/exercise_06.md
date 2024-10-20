# WordPress with Docker Compose

The Docker client can be cumbersome for creating containers, as well as for creating and linking the rest of the objects together.

To automate the creation, startup, and stopping of a container or a set of them, Docker provides a tool called Docker Compose.

To begin, let's stop and remove what we have created:

Clear the current work:

```
docker container stop wordpress wordpress-db
docker container rm wordpress wordpress-db
docker volume rm wordpress-db
```

## Docker Compose

Compose is a tool to define and run multi-container applications. With a single command, we can create and start all the services we need for our application.

The most common use cases for docker-compose are:

- Development environments
- Automated testing environments (continuous integration)
- Deployment on single hosts (not clusters)

_Compose_ has commands to manage the entire lifecycle of our application:

- Start, stop, and rebuild services.
- heck the status of services.
- View logs.
- Run a command in a service.

## Automated container creation

In the same directory where we were in the previous step (~/Sites/wordpress), create a file named `docker-compose.yaml` with the following content:

```
version: '3.9'

services:
db:
image: mariadb:10.3.9
volumes: - data:/var/lib/mysql
environment: - MYSQL_ROOT_PASSWORD=secret - MYSQL_DATABASE=wordpress - MYSQL_USER=manager - MYSQL_PASSWORD=secret
web:
image: wordpress:4.9.8
depends_on: - db
volumes: - ./target:/var/www/html
environment: - WORDPRESS_DB_USER=manager - WORDPRESS_DB_PASSWORD=secret - WORDPRESS_DB_HOST=db
ports: - 8080:80

volumes:
data:

```

Compose files are divided into three sections: services, volumes, and networks; and they must specify a version number. It allows us to do practically the same things we can do with the Docker client, but automatically.

_We won’t cover the networks section here._

With this file, we can achieve the same results as in the previous chapter, but with the advantage of describing all our requirements in a single file.

## Starting Services
Let’s run this application and then explain it. Start the application with Compose:

```
docker-compose up -d
```

When we start the application, Compose shows us the services it has started:

```
$ docker-compose up -d
Creating network "wordpress_default" with the default driver
Creating volume "wordpress_data" with local driver
Creating wordpress_db_1 ...
Creating wordpress_db_1 ... done
Creating wordpress_web_1 ...
Creating wordpress_web_1 ... done
```

The `-d` parameter is similar to what we saw in `docker run`: it allows us to run the services in the background.

Viewing Active Containers:

```
$ docker container ls
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
a07b5d4d3982 wordpress:4.9.8 "docker.s…" 10 seconds ago Up 8 seconds 0.0.0.0:8080->80/tcp wordpress_web_1
d9204884cec5 mariadb:10.3.9 "docker.s…" 11 seconds ago Up 10 seconds 3306/tcp wordpress_db_1
```

We can also see the containers with Compose:

```
$ docker-compose ps
        Name                    Command               State          Ports
    -------------------------------------------------------------------------------
    wordpress_db_1    docker-entrypoint.sh mysqld      Up      3306/tcp
    wordpress_web_1   docker-entrypoint.sh apach ...   Up      0.0.0.0:8080->80/tcp

```

#### Important Notes:

- `docker-compose ps` only shows information about the services defined in docker-compose.yaml, whereas Docker shows everything.
- When we create containers with `Docker` without specifying a name, it assigns a random one by default. In Compose, the prefix is the directory name, and the suffix is the service name (e.g., wordpress_db_1). The number indicates the instance count. We can start more than one instance of the same service.

If we go to http://localhost:8080/, we will see the WordPress installation again.

## Stopping Services

We can stop services with:

```

docker-compose stop

```

## Removing Services
We can remove services with:

```

docker-compose down

```

This removes the containers but not the volumes. If we created the application correctly, our data is safe.

To also remove the volumes:

```

docker-compose down -v

```

## Configuration Structure

Let’s break down the configuration:

```

version: '3.9'

```

Compose is updated frequently, and the configuration file gains new functionalities. Version '3.9' (note that it’s a string, so it must be in quotes) is the latest, and you can check all its features in the reference page for version 3 of Compose.

```

volumes:
data:

```

We’ve already mentioned that it’s important to store volatile application `data` in volumes. In this case, we’ve created a volume named data. Remember that Compose always prefixes the directory name, so the actual volume name is wordpress_data. We can verify this with the Docker client, as we did in the volumes chapter:

```

    $ docker volume ls
    DRIVER              VOLUME NAME
    local               wordpress_data

```

First, the database:

```

services:
db:
image: mariadb:10.3.9
volumes: - data:/var/lib/mysql
environment: - MYSQL_ROOT_PASSWORD=secret - MYSQL_DATABASE=wordpress - MYSQL_USER=manager - MYSQL_PASSWORD=secret

```

After opening the services section, the first level indicates the service name db, which generates the container wordpress_db. What follows is the same as what we did in the previous section, but parameterized. If you recall, to start our database, we specified the image (line 3), mounted volumes (line 4), and then set environment variables to configure the container (line 6).

This is equivalent, except for the name, to:

```

$ docker run -d --name wordpress-db \
 --mount source=wordpress-db,target=/var/lib/mysql \
 -e MYSQL_ROOT_PASSWORD=secret \
 -e MYSQL_DATABASE=wordpress \
 -e MYSQL_USER=manager \
 -e MYSQL_PASSWORD=secret mariadb:10.3.9

```

Next is our WordPress container:

```

services:
web:
image: wordpress:4.9.8
depends_on: - db
volumes: - ./target:/var/www/html
environment: - WORDPRESS_DB_USER=manager - WORDPRESS_DB_PASSWORD=secret - WORDPRESS_DB_HOST=db
ports: - 8080:80
In this case, the equivalent command is:

```

```
$ docker run -d --name wordpress \
 --link wordpress-db:mysql \
 --mount type=bind,source="$(pwd)"/target,target=/var/www/html \
 -e WORDPRESS_DB_USER=manager \
 -e WORDPRESS_DB_PASSWORD=secret \
 -p 8080:80 \
 wordpress:4.9.8

```

The parameter equivalences are as follows:

```

| parámetro _Docker_ | parámetro _Composer_ |
| ------------------ | -------------------- |
| --link             | depends_on           |
| --mount            | volumes              |
| -e                 | environment          |
| -p,--publish       | ports                |
|                    | image                |

```

If we restart the computer, the containers will be stopped. We can restart them with docker start or docker-compose start. This is the default behavior and what we want in a development environment.

However, in other environments or specific cases, we may want a container to retain the same state it had before restarting the machine (started or stopped).

To achieve this, we use the restart parameter. In the case of our database, the configuration would look like:

```
services:
db:
image: mariadb:10.3.9
restart: unless-stopped
volumes: - data:/var/lib/mysql
environment: - MYSQL_ROOT_PASSWORD=secret - MYSQL_DATABASE=wordpress - MYSQL_USER=manager - MYSQL_PASSWORD=secret
```

The equivalent command in the console would be:

```

$ docker run -d --name wordpress-db \
--restart unless-stopped
--mount source=wordpress-db,target=/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=secret \
-e MYSQL_DATABASE=wordpress \
-e MYSQL_USER=manager \
-e MYSQL_PASSWORD=secret mariadb:10.3.9

```

Other restart values include: no (default), always, and on-failure.


## My Solution ✅

After creating the docker-compose.yaml file (will be named exercise_06_docker-compose.yaml), 
Execute the app 

```
docker compose up -d
```


When we start the application, Compose shows us the services it has started:
