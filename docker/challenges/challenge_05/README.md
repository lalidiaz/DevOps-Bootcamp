# My Solution ✅

These are my solutions to the challenge and the steps I’ve followed.
I’ll be committing regularly to document my thinking process as I tackle each issue and find solutions.

### 1. [WARNING] `version` is obsolete

Delete version attribute in docker-compose.yaml file.

### 2. [ERROR] service "app" refers to undefined network node-network: invalid compose project

Added missing property in `docker-compose.yaml` file

```
networks:
  node-network:
    name: node-network
```

### 3. [ERROR] ! nginx Warning pull access denied for javielrezende/nginx, repository does not exist

Replace the following configuration in `docker-compose.yaml`

```
build:
    context: ./nginx
    image: javielrezende/nginx
```

to this:

```
build:
    context: ./nginx
    dockerfile: Dockerfile
```

And after reviewing the other configuration builds, I modified the following:

```
build:
    context: ./mysql
    dockerfile: Dockerfile
```

```
build:
    context: ./node
    dockerfile: Dockerfile
```

### 4. [ERROR] => ERROR [db internal] load metadata for docker.io/library/mysql:5.7

_Failed to solve: mysql:5.7: failed to resolve source metadata for docker.io/library/mysql:5.7: no match for platform in manifest: not found_

I head over to mysql directory and build the image to check the logs in the console to see if I get other insights of what could be the problem.

```
cd mysql
docker build -t sqldb .
```

Error:

```
------
 > [db internal] load metadata for docker.io/library/mysql:5.7:
------
failed to solve: mysql:5.7: failed to resolve source metadata for docker.io/library/mysql:5.7: failed to do request: Head "https://registry-1.docker.io/v2/library/mysql/manifests/5.7": dial tcp: lookup registry-1.docker.io on 127.0.0.53:53: server misbehaving
```

After reviewing the docker image, I found this:

<img width="1247" alt="Screenshot 2024-10-31 at 9 48 55 AM" src="https://github.com/user-attachments/assets/b9f7e9e1-1313-4000-805f-93021870f748">

So I changed this line in `./mysql/Dockerfile`

```
FROM mysql:latest
```

### 5. [ERROR] ERROR [app 4/6] RUN install

```
 => ERROR [app 4/6] RUN install
------
 > [app 4/6] RUN install:
0.140 install: missing file operand
0.140 Try 'install --help' for more information.
------
```

Add the following to `./node/Dockerfile`

```
RUN npm install
```

### 6. [WARNING] LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format

When creating the docker image inside `/node` directory, I found the following warning:

```
 1 warning found (use docker --debug to expand):
 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 9)
Dockerfile:7
--------------------
   5 |     COPY . .
   6 |
   7 | >>> RUN apt-get update && apt-get install -y wget
   8 |
   9 |     ENV DOCKERIZE_VERSION v0.6.1
--------------------
```

To solve this, I added the correct format to the ENV variable:
`ENV DOCKERIZE_VERSION=v0.6.1`

### 7. [ERROR] => ERROR [app 4/5] RUN apt-get update && apt-get install -y wget

I head over to `./node/Dockerfile` and check the following command:

```
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
```

I found out it's trying to install [Dockerize](https://github.com/jwilder/dockerize), a tool by jwilder that is used for managing and configuring containerized applications.

I updated the `./node/Dockerfile`:

- Add node:latest tag
- Update RUN command
- Add COPY package\*.json ./
- Add CMD

```
FROM node:latest

WORKDIR /usr/src/app

ENV DOCKERIZE_VERSION=v0.8.0

RUN apt-get update \
    && apt-get install -y wget \
    && wget -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xzf - -C /usr/local/bin \
    && apt-get autoremove -yqq --purge wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
```

### 8. [ERROR] => Error response from daemon: driver failed programming external connectivity on endpoint nginx

While running `docker compose up -d` I run into the following error:

```
Error response from daemon: driver failed programming external connectivity on endpoint nginx (eb1caad382768fd7954946a392d81017b334445852a4aa197abcadf132324223): failed to bind port 0.0.0.0:8080/tcp: Error starting userland proxy: listen tcp4 0.0.0.0:8080: bind: address already in use
```

To find out what application is using port 8080

```
sudo lsof -i :8080
```

The output:

```
COMMAND     PID    USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
java    2203265 jenkins    9u  IPv6 3354963      0t0  TCP *:http-alt (LISTEN)
```

Kill the process running in port 8080:

```
sudo kill 2203265
```

Run `docker compose up -d` and the containers started.

localhost:8080

[nginx image here]

### 9. [ERROR] => localhost:3000 not working

After checking the console, I received the following error:

```
(HTTP code 500) server error - error while creating mount source path '/host_mnt/Users/lauradiaz/Desktop/DevOps-Bootcamp/docker/challenges/challenge_05/devops-static-web/node': mkdir /host_mnt/Users/lauradiaz/Desktop: operation not permitted
```

I created a named volume:

```
volumes:
  app_data:
```

The containers are now created without any errors, but **localhost:3000** is still not working.

I can view the logs of `app` container:

```
app    | 2024/10/31 07:59:20 Connected to tcp://db:3306
app    | Conectando por el puerto 3000
app    | /usr/src/app/routes.js:15
app    |         results.forEach(element => {
app    |                 ^
app    |
app    | TypeError: Cannot read properties of undefined (reading 'forEach')
```

This could indicate an issue with the MySQL database. I added the following code to handle the error within `connection.query`.

```
connection.query("SELECT * FROM peoples", (error, results) => {
if (error) {
    console.error("Database error:", error);
    return res.status(500).send("Database error occurred");
  }
```

The response:

```
Database error: Error: getaddrinfo ENOTFOUND db
```

To troubleshoot the issue, I followed these steps:

1. Add the following to `init.sql`:

```
-- Add some initial data
-- INSERT INTO peoples (name) VALUES ('John Doe');
-- INSERT INTO peoples (name) VALUES ('Jane Doe');
```

2. Log into the db container and open the MySQL shell to check if the script executes when running `docker compose up -d`.

```
docker exec -it db bash
mysql -u root -p
```

Check whether the table was created successfully and contains data:

```
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| node_db            |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)
```

Show data in table `node_db`

```
USE node_db;
mysql> SELECT * FROM peoples;
+----+----------+
| id | name     |
+----+----------+
|  1 | John Doe |
|  2 | Jane Doe |
+----+----------+
```

Great! The `init.sql` script is executing, and the data is in the table.

Now, I’ll remove the initial data from the `init.sql` script and revert to the original code, where this data is inserted in the app's route.

1. Log into the command line interface of MySQL:

```
docker exec -it db bash
bash-5.1# mysql -u root -p
Enter password:
```

Check if database exists:

```
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| node_db            |
| performance_schema |
| sys                |
+--------------------+
```

```
mysql> USE node_db;
mysql> SELECT * FROM peoples;
Empty set (0.00 sec)
```

Now, I suspect the problem might be this line of code in `./node/routes.js`

```
const sql = `INSERT INTO peoples(name) VALUES('${faker.name.findName()}')`;
```

After reviewing the logs from the Node container, I noticed an error indicating that faker is undefined. I checked the [faker docs](https://www.npmjs.com/package/faker) and found that it might be obsolete, so I switched to the [@faker-js package](https://www.npmjs.com/package/@faker-js/faker) and made the following changes:

- Install @faker-js/faker package.

```
const { fakerPT_BR } = require("@faker-js/faker");
```

- Modify the import from faker according to the documentation.
- In `connectionDb.js`:
  - Change the database file name to the default "node_db" instead of "nodedb" as previously defined.
  - Update the connection import library.
  - As stated in the documentation, I decided to use createPool because it offers performance benefits by reusing connections instead of creating a new one for each query.

```
const mysql = require("mysql2/promise");
require("dotenv").config();

const config = {
  host: process.env.HOST || "db",
  user: process.env.USER || "root",
  password: process.env.PASSWORD || "root",
  database: process.env.DATABASE || "node_db",
};

const connection = mysql.createPool(config);

module.exports = connection;
```

- Install the **mysql2** package, as it offers native Promise support, better performance, and protection against SQL injection.

```
// package.json
"mysql2": "^3.11.3"
```

- Add try-catch blocks to handle errors in `./node/routes.js`.
- Use async/await to insert data into the "peoples" table.

```
routes.get("/", async (_, res) => {
  try {
    const name = fakerPT_BR.person.fullName();

    await connection.query("INSERT INTO peoples(name) VALUES(?)", [name]);

    const [results] = await connection.query("SELECT * FROM peoples");

    let html = "<h1>Desafio Devops!</h1>";
    html += results.map((element) => element.name).join("<br>");

    return res.send(html);
  } catch (error) {
    console.error("Error in routes:", error);
    return res.status(500).send("An error occurred");
  }
});
```

Now, if I log into the MySQL command line, I can see the data in the peoples table:

```
mysql> SELECT * FROM peoples;
+----+-------------------+
| id | name              |
+----+-------------------+
|  1 | J�lio C�sar Costa |
+----+-------------------+
1 row in set (0.00 sec)
```

<img width="1462" alt="Screenshot 2024-10-31 at 6 27 35 PM" src="https://github.com/user-attachments/assets/22ae8cb5-b3bb-4ba4-bcec-f922a8541566">
