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
