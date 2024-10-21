# Example 07

## Development Environment for PHP using Docker 🐳

You want to learn PHP, but the configurations have overwhelmed you, and your desire to learn is dwindling. Don’t stop your learning—there's always a solution to problems. Installing PHP and configuring a web server on Windows is very easy, but on Linux and macOS, it's a different situation. You need to know about the terminal, a code editor, vim, nano, be advanced... and much more.

The tool we're going to use, which allows us to work with PHP, a web server, and the terminal, is Docker.

**Docker**: It's a software platform that allows you to quickly create, test, and deploy applications.

**Docker-compose**: A tool to define and run multi-container applications; it simplifies using Docker by using YAML files, making it easier to create containers that interact with each other, connect them, enable ports, volumes, etc.

**Web server**: Software that allows users to view a webpage in their browser. The most commonly used servers are Apache and Nginx.

## docker-compose.yml Configuration

Create the `docker-compose.yml` file with the following configuration:

```
# Docker-compose.yml files are versioned, meaning it's very important to indicate the version of the instructions we want to use.

version: "3.9"

# Nginx server

services:
web: # version
image: nginx:alpine # Port 8080
ports: - "8080:80"
volumes: - ./src:/var/www/html - ./default.conf:/etc/nginx/conf.d/default.conf
links: - php-fpm

# PHP-FPM configuration

php-fpm:
image: php:8-fpm
volumes: - ./src:/var/www/html

```

Create a new file named default.conf with the following configuration, at the same level as `docker-compose.yml`.

```
# Don't worry about the configurations.

server {
index index.php index.html;
server_name phpfpm.local;
error_log /var/log/nginx/error.log;
access_log /var/log/nginx/access.log;
root /var/www/html;

location ~ \.php$ {
try_files $uri =404;
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
fastcgi_pass php-fpm:9000;
fastcgi_index index.php;
include fastcgi_params;
fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
fastcgi_param PATH_INFO $fastcgi_path_info;
}
}

```

## Docker-compose Commands

Create and start the container:

```
# Create and start the container

# -d starts the containers in the background and leaves them running.

➜ docker-compose up -d
```

```
# Create and start the container in the foreground

➜ docker-compose up
```

For effective interaction and a positive learning experience, the .php files are created inside the `src` directory.

```

# Main directory

├── docker-php
│ ├── default.conf
│ ├── docker-compose.yml
│ ├── README.md
│ └── src # Directory
│ ├── holi.php
└── └── index.php

# Inside the src folder, create the index.php file.
```

Create the index.php file in the src directory:

```
# content of index.php

<?php
  echo phpinfo();

```

Go to your favorite browser and visit the following link: `http://localhost:8080`. If there’s an error with the local server connection, add `php-fpm`. to `localhost:8080`. The address will look like this:

```
http://php-fpm.localhost:8080/
```

That’s it! You have your first Nginx server running with PHP using Docker-compose.

## Interact with the Docker-compose terminal

Enter `Docker-compose` bash:

```
➜ docker-compose exec php-fpm bash
```

Create the `variables.php` file:

```
# create file

touch variables.php
```

`variables.php`:

```
<?php
// Define variables
$numero_1 = 8;
$numero_2 = 7;

// Define constants
define("NUMERO_PI", 3.14);
// define("NUMERO_PI", 14);

echo NUMERO_PI;

echo "\n";

echo $numero_1 + $numero_2;

echo "\n";

```

Run the `PHP` file in the terminal:

```
php variables.php
```

Use the `exit` command to close bash.

Stop the container running in the background:

```
# Background
docker-compose down
```

Stop container in the foreground:

```
# Foreground
ctl + c
```

Using Docker to learn a programming language offers an endless opportunity to keep learning.



## My Solution ✅

Create and start a container

```
docker compose up -d
```