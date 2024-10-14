# Example: Deploying MediaWiki with Docker

MediaWiki is a web application written in PHP that allows you to manage a wiki. In this example, you will learn how to deploy MediaWiki in containers using the official image available on DockerHub. We'll explore how to use specific tags to deploy different versions of the application.

## Using Tags for Image Versions

Tags in Docker allow you to specify different versions of an image. When using an image without specifying a tag, Docker uses the latest tag by default, which typically corresponds to the most recent version.

### The `latest` Tag
In the case of MediaWiki, the `latest` tag currently corresponds to version ` 1.40.1`. Other tags that point to the same version include `1.40.1`, `1.40`, and stable.

### Tags with Base Images and Additional Services
Some tags not only indicate the application version but also the environment configuration. For example:

- 1.40.1-fpm: This tag deploys MediaWiki with a PHP-FPM server, useful for environments where PHP is managed with this type of server.
- 1.40.1-fpm-alpine: This version uses an Alpine Linux base image, which is known for being lightweight and efficient.

### Installing Different Versions of MediaWiki

We will deploy three different versions of MediaWiki in separate containers, each listening on a different port so that you can access them simultaneously.

### Deploy the Latest Version (latest)

First, we’ll deploy the latest version of MediaWiki:

```
docker run -d -p 8080:80 --name mediawiki1 mediawiki
```

- `-d`: Runs the container in detached mode (background).
- `-p` 8080:80: Maps port 80 of the container to port 8080 on your machine.
- `--name mediawiki1`: Assigns a name to the container.

Access http://localhost:8080 and verify that you have installed version `1.40.1`.

### Deploy an Older Version (1.39.5)

Now, we’ll deploy an older version of MediaWiki in a new container:

```
docker run -d -p 8081:80 --name mediawiki2 mediawiki:1.39.5
```

Access http://localhost:8081 to view version 1.39.5 of MediaWiki.

### Deploy Another Older Version (1.38.6)

Lastly, we’ll deploy an even older version of MediaWiki:

```
docker run -d -p 8082:80 --name mediawiki3 mediawiki:1.38.6
```

Access http://localhost:8082 to verify that version 1.38.6 is installed.

### Important Notes:

- **Download Optimization**: The first time you download an image, Docker downloads all the necessary layers. However, when downloading additional versions of the same image, Docker only downloads the layers that differ from the previous version, optimizing time and disk space.
- **Version Compatibility**: When using different versions, be sure to review the compatibility with plugins and extensions you plan to use, as some features may change between versions.
