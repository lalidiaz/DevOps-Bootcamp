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
