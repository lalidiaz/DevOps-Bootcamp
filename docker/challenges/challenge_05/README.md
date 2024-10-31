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
