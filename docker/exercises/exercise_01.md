# Example 1: Deployment of the Roxsbook Application

In this example, we will deploy a web application that requires two services (web service and database service) to function. The application is called Guestbook and needs the following two services:

- The Guestbook application is a web application developed in Python that is served on port 5000/tcp. We will use the image roxsross12/guestbook:2.0.0 to create the container.
- This application stores information in a non-relational Redis database, which uses port 6379/tcp for connection. We will use the Redis image to create the container.

By default, the Guestbook application uses the name redis to connect to the database, so we must name the Redis container with that name to ensure proper name resolution. Next, we will see how we can configure the Guestbook application (using an environment variable) to connect to a Redis container with a different name.

The two containers must be connected on the same user-defined bridge network and must have name access (DNS resolution) since we do not initially know what IP address each container will take. Therefore, we will create the containers on the same network:

```
docker network create red_guestbook
```

To run the containers:

```
$ docker run -d --name redis --network red_guestbook -v /opt/redis:/data redis redis-server --appendonly yes

$ docker run -d -p 80:5000 --name guestbook --network red_guestbook roxsross12/guestbook:2.0.0
```

Some observations:

- It is not necessary to map the port of the Redis database container since we will not be accessing it from the outside. However, the Guestbook application will be able to access the database because they are connected to the same network.
- Naming the database container redis creates a DNS entry that resolves that name to the container's IP address. As mentioned, the Guestbook application uses that name to access it by default.
- To achieve data persistence in the Redis database container, we mount a bind mount (we could also have used a Docker volume) in the /data directory of the container. Additionally, we run the command redis-server --appendonly yes to save the database data in that directory.

Assuming that the Docker Host's IP address is 192.168.121.54 or localhost, we could access the application through a web browser.

## Configuration of the Roxsbook Application
As mentioned earlier, when creating the image roxsross12/guestbook:2.0.0, an environment variable (called REDIS_SERVER) is created to configure the name of the Redis database server being accessed. By default, the value of this variable is redis. Therefore, it is necessary for the database container to be named redis so that the Guestbook container can connect to the database.

If we create a Redis container with a different name, for example:

```
$ docker run -d --name contenedor_redis --network red_guestbook -v /opt/redis:/data redis redis-server --appendonly yes
```

We will need to configure the Guestbook application to access the Redis database using the name contenedor_redis. Thus, during the creation, we will have to define the environment variable REDIS_SERVER, for which we execute:

```
$ docker run -d -p 80:5000 --name guestbook -e REDIS_SERVER=contenedor_redis --network red_guestbook roxsross12/guestbook:2.0.0
```

## My Solution ✅
