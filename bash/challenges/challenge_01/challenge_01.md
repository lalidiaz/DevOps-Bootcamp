# Challenge 01

Design an Automated Bash Script for Building a Python Application Using the Flask Framework

## 📋 Instructions

### 1. Clone the repository:

```
git clone -b devops-automation-python https://github.com/roxsross/devops-static-web.git
```

### 2. Create a script named automation.sh, and a model can be found in the repo. The script should contain the following steps.

Grant permission with:

```
chmod u+x automation.sh
```

#### 2.1 Create a temporary folder named tempdir and its subdirectories tempdir/templates and tempdir/static.

```
mkdir -p tempdir/templates tempdir/static
```

#### 2.2 Inside the tempdir folder, copy the static/ folder, templates/ folder, and the application challenge2_app.py.

```
cp -r /static /templates challenge2_app.py /tempdir
```

#### 2.3 The script should construct a Dockerfile, which will be located inside the temporary folder tempdir.

```
cat << EOF > tempdir/Dockerfile
    FROM python
    RUN pip install flask
    COPY ./static /home/myapp/static/
    COPY ./templates /home/myapp/templates/
    COPY desafio2_app.py /home/myapp/
    EXPOSE 5050
    CMD ["python3", "/home/myapp/desafio2_app.py"]
EOF
```

#### 2.4 The Dockerfile should contain the following information:

```
FROM python
RUN pip install flask
COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY challenge2_app.py /home/myapp/
EXPOSE 5050
CMD python3 /home/myapp/challenge2_app.py
```

### Optional Script Test

#### 2.5 The script should allow building the application with the following command:

```
docker build -t appname .
```

#### 2.6 Additionally, it should start the application with the command:

```
docker run -t -d -p 5050:5050 --name appnamerunning appname
```

#### 2.7 As the final step of the script, it should output the result of:

```
docker ps -a
```

#### 2.8 If the build is successful, check the logs with:

```
docker logs "CONTAINER ID"
```

#### 2.9 You can validate in the browser at http://localhost:5050 or check the IP with:

```
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name
```


## My Solution ✅

My bash script:

```
#!/bin/bash

# Create a temporary folder named tempdir and its subdirectories tempdir/templates and tempdir/static.
mkdir -p tempdir/templates tempdir/static

# Confirm the directory structure has been created
echo "Temporary directories created: tempdir, tempdir/templates, tempdir/static"

# Inside the tempdir folder, copy the static/ folder, templates/ folder, and the application desafio2_app.py.
cp -r static tempdir
cp -r templates tempdir
cp desafio2_app.py tempdir

# Construct a Dockerfile, which will be located inside the temporary folder tempdir.
cat << EOF > tempdir/Dockerfile
    FROM python
    RUN pip install flask
    COPY ./static /home/myapp/static/
    COPY ./templates /home/myapp/templates/
    COPY desafio2_app.py /home/myapp/
    EXPOSE 5050
    CMD ["python3", "/home/myapp/desafio2_app.py"]
EOF

# Build the image
docker build -t desafio2_app ./tempdir

# Run the app
docker run -t -d -p 5050:5050 --name nombreapprunning desafio2_app
```