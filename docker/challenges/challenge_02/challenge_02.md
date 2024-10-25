# Challenge: Create an Nginx Container

## Objective

In this challenge, you will create a Docker container running Nginx that serves web content from a specific folder. The container will be accessible at `http://localhost:9999`.

## Instructions

1. Create the Nginx container:

- Use Docker to create a container named bootcamp-web.
- Configure the container to run Nginx and make it accessible at http://localhost:9999.

2. Clone the repository:

- From your local machine, clone the following repository, which contains the web content:
  ```
  git clone -b devops-simple-web https://github.com/roxsross/devops-static-web.git
  ```

3. Copy the content to the container:

- Copy the content from the bootcamp-web folder of the cloned repository to the Nginx container’s directory where web files are served, typically /usr/share/nginx/html.

4. Verify the file copy:

- Run ls from outside the container to ensure the files have been correctly copied to the Nginx server’s path.
  Access the website:

5. Acces Web Site

- Open your browser and go to `http://localhost:9999` to view the content served by Nginx from your container.

## My Solution ✅

My Dockerfile

```
FROM nginx:alpine
COPY ./devops-static-web/bootcamp-web /usr/share/nginx/html
EXPOSE 9999
CMD ["nginx", "-g", "daemon off;"]
```

Build Image

```
docker build . --tag simple-nginx:v1
```

Verify image

```
docker images
```

Create container from new image

```
docker run -d --name my_nginx -p 9999:80 simple-nginx:v1
docker ps
```

<img width="1914" alt="Screenshot 2024-10-21 at 11 20 48 PM" src="https://github.com/user-attachments/assets/a0a59684-e8b9-44f3-95dd-80f9de53da3a">
