# Dockerize & Deploy: Full Stack Challenge with Java, Go, and PostgreSQL

The goal is to automate the build, testing, packaging, and deployment of the Java and Go applications, along with the PostgreSQL database, using Docker and Docker Compose. This involves incorporating semantic versioning practices and ensuring smooth continuous integration to guarantee continuous delivery and system stability.

Containerize a REST API in Java, a web application in Go, and a PostgreSQL database, then use Docker Compose to orchestrate the containers. Additionally, this includes pushing the images to Docker Hub and a bash script to handle versioning published on Docker Hub.

Docker Challenge:

### Arquitecture

![image](https://github.com/user-attachments/assets/8299829e-a1ff-43ca-a297-72a9d1c9f410)

### Repository

```
git clone -b ejercicio2-dockeriza https://github.com/roxsross/bootcamp-devops-2023.git

cd 295words-docker
```

### API REST en Java

Provide a Java project that serves words from a database. Containerize the application using a Dockerfile.

```
Version de JAVA >= 18
Version de Maven >= 3
se recomienda el uso de amazoncorretto
Conexion string base de datos: postgresql://db:5432/postgres [linea 24 , Main.java]
Port 8080
```

### Web Application in Go

The web application in Go calls the Java API and converts the words into sentences. Containerize the application using a Dockerfile.

```
Imagen recomendada: golang:alpine
```

### PostgreSQL Database:

Set up a PostgreSQL database to store the words.

start data words.sql

```
CREATE TABLE nouns (word TEXT NOT NULL);
CREATE TABLE verbs (word TEXT NOT NULL);
CREATE TABLE adjectives (word TEXT NOT NULL);

INSERT INTO nouns(word) VALUES
  ('cloud'),
  ('elephant'),
  ('gø language'),
  ('laptøp'),
  ('cøntainer'),
  ('micrø-service'),
  ('turtle'),
  ('whale'),
  ('gøpher'),
  ('møby døck'),
  ('server'),
  ('bicycle'),
  ('viking'),
  ('mermaid'),
  ('fjørd'),
  ('legø'),
  ('flødebolle'),
  ('smørrebrød');

INSERT INTO verbs(word) VALUES
  ('will drink'),
  ('smashes'),
  ('smøkes'),
  ('eats'),
  ('walks tøwards'),
  ('løves'),
  ('helps'),
  ('pushes'),
  ('debugs'),
  ('invites'),
  ('hides'),
  ('will ship');

INSERT INTO adjectives(word) VALUES
  ('the exquisite'),
  ('a pink'),
  ('the røtten'),
  ('a red'),
  ('the serverless'),
  ('a brøken'),
  ('a shiny'),
  ('the pretty'),
  ('the impressive'),
  ('an awesøme'),
  ('the famøus'),
  ('a gigantic'),
  ('the gløriøus'),
  ('the nørdic'),
  ('the welcøming'),
  ('the deliciøus');

```

```
Imagen recomendada: postgres:15-alpine
datos de conexion:
POSTGRES_USER: postgres
POSTGRES_PASSWORD: postgres
Recuerde de inyectar los datos antes de iniciar el contenedor
```

### Docker Compose

Create a `docker-compose.yml` file that defines services for each container (API, web, DB) and configures the necessary connections between them.

### Push to Docker Hub

- Create Docker Hub accounts if you don’t have them already.
- Push your container images to Docker Hub with semantic versioning using tags. You can use the docker push command.

### Bash Script

Create a bash script called, for example, deploy.sh that automates the process. The script should include steps to build the Docker images, tag them with versions, push them to Docker Hub, and run Docker Compose.

Use tools like git describe or semantic-release to manage semantic versioning automatically.

Remember to document your code, Dockerfiles, and `docker-compose.yml` properly.

The bash script should be executable and easy to understand to facilitate the automation of the process.


# My Solution ✅


## 🥷🔍TROUBLESHOOTING
While working on this challenge, I encountered an issue in the source code that was affecting a key feature: **I was unable to connect to the Postgres database from the API service**. After reviewing the API container's logs, I identified that the issue was caused by a line in the `Main.java` file:

```
  try (Connection connection = DriverManager.getConnection("jdbc:postgresql://db:5432/postgres", "postgres",  "postgres")) { ...
```

The error message was:
```
2024-11-12 15:30:40 org.postgresql.util.PSQLException: The server requested SCRAM-based authentication, but the password is an empty string.
```

This indicated a clear authentication issue between the Postgres database and the API service.

After extensive research, I followed these steps to resolve the issue:

1. I modified the connection string in `Main.java`
```
    private static String randomWord(String table) {
        String dbUser = System.getenv("POSTGRES_USER");
        String dbPassword = System.getenv("POSTGRES_PASSWORD");
        try (Connection connection = DriverManager.getConnection("jdbc:postgresql://db:5432/postgres", dbUser, dbPassword)) {
```

2. I have to rebuild my Java application so I run 
```
mvn clean package
```

3. After this, I run the following commands:
```
docker compose down
docker compose up -d
```


## RESULTS

