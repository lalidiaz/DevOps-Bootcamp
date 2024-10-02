# Exercise 09

## Deploy Flask easily with Gunicorn and Nginx
In this tutorial, I will guide you through the process of deploying a Flask web application. Flask is a lightweight web application framework written in Python.

- [x] Deploy a Flask web application.
- [x] Use Gunicorn as the WSGI server.
- [x] Configure Nginx as a reverse proxy.

### 1. Install the Python Virtual Environment

First, access and update the package list:

```
sudo apt-get update && sudo apt-get upgrade
```

Then, install the Python virtual environment package:

```
sudo apt-get install python3-venv
```

### 2. Configure the Virtual Environment

**Create a new directory for your Flask application and navigate to it:**

```
mkdir helloworld
cd helloworld
```

**Create a virtual environment named 'venv':**

```
python3 -m venv venv
```

**Activate the virtual environment:**

```
source venv/bin/activate
```


### 3. Install Flask
Within the virtual environment, install Flask using pip:

```
pip install Flask
```

### 4. Create a Simple Flask API

Create a file named app.py 

```
sudo vi app.py
```

And add the following code:

```
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'

if __name__ == "__main__":
    app.run()
```

#### 5. Verify the Flask Application

Run the Flask application to verify that it is working:

```
python app.py
```
<img width="806" alt="Screenshot 2024-10-02 at 10 30 54 PM" src="https://github.com/user-attachments/assets/25f92828-6c31-459b-9145-4d953c1aebdf">


#### 6.Run the Gunicorn WSGI Server

Run the Gunicorn WSGI server to serve the Flask application. When I run Flask, I am actually running the development WSGI server from Werkzeug, which forwards requests from a web server. Since Werkzeug is only for development, I need to use Gunicorn, which is a production-ready WSGI server, to serve my application.

**Install Gunicorn using pip:**

```
pip install gunicorn
```

<img width="927" alt="Screenshot 2024-10-02 at 4 23 12 PM" src="https://github.com/user-attachments/assets/c8d8e0af-ad8f-4ac9-be55-7756e78ad9c3">


**Run Gunicorn to serve the Flask application:**

```
gunicorn -b 0.0.0.0:8000 app:app
```
<img width="982" alt="Screenshot 2024-10-02 at 4 27 40 PM" src="https://github.com/user-attachments/assets/4cd4ee5c-d1f6-4c28-9dc3-2d9d05bd3a78">

Use systemd to manage Gunicorn. Systemd is a startup manager for Linux.
I use it to restart Gunicorn if the server restarts or reboots for any reason. 
I will create a service file in the /etc/systemd/system directory and specify what should happen with Gunicorn when the system reboots. 
I will add three sections to the systemd unit file: Unit, Service, and Install.

- Unit — This section is for the project description and some dependencies.
- Service — To specify the user/group under which we want to run this service. It also includes information about the executables and commands.
- Install — Indicates to systemd when during the boot process to start this service.

That said, create a unit file in the /etc/systemd/system directory


#### 7. Manage Gunicorn with systemd

```
sudo nano /etc/systemd/system/helloworld.service
```


Add the following configuration:
```
[Unit]
Description=Instancia de Gunicorn para una aplicación simple de hello world
After=network.target

[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/helloworld
ExecStart=/home/ubuntu/helloworld/venv/bin/gunicorn -b localhost:8000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
```

<img width="1023" alt="Screenshot 2024-10-02 at 5 17 08 PM" src="https://github.com/user-attachments/assets/e974f968-1b13-4c5f-8ff6-cbb21ca46cfc">


Enable and start the service:
```
sudo systemctl daemon-reload
sudo systemctl start helloworld
sudo systemctl enable helloworld
```


Check if the application is running with:

```
curl localhost:8000
```

<img width="1398" alt="Screenshot 2024-10-02 at 5 22 30 PM" src="https://github.com/user-attachments/assets/256fa07a-c663-4382-a1bd-580af755f7b1">


#### 8.Configure Nginx as a Reverse Proxy

Install Nginx:

```
sudo apt-get install nginx
```

Start and enable the Nginx service:

```
sudo systemctl start nginx
sudo systemctl enable nginx
```

Edit the default Nginx configuration file:

```
sudo nano /etc/nginx/sites-available/default
```

Add the following code at the beginning of the file (below the default comments):

```
upstream flaskhelloworld {
    server 127.0.0.1:8000;
}
```

Add a proxy_pass to flaskhelloworld in the / location:

```
location / {
    proxy_pass http://flaskhelloworld;
}
```


Restart Nginx for the changes to take effect:

```
sudo systemctl restart nginx
```

<img width="815" alt="Screenshot 2024-10-02 at 10 55 10 PM" src="https://github.com/user-attachments/assets/339e4fa9-9959-4dd2-b61b-9cc6491f0317">
