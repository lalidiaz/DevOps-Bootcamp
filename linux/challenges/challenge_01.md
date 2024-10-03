# Challenge 01

## Deploy the Flask Application 📚"Book Library"📚 with Nginx and Gunicorn
Welcome to the deployment challenge! 
In this challenge, I will deploy a web application developed in Python using the Flask framework, with Nginx as a reverse proxy and Gunicorn as the WSGI server.

### Challenge Steps:

### 1. Server setup with preferred distro

### 2. Environment Preparation:
- Install Python 3, pip, and virtualenv.
- Create a virtual environment for the application.
- Install Flask and other necessary dependencies in the virtual environment.


### 3. Application Deployment:

I clone the repository:
```
git clone -b booklibrary https://github.com/roxsross/devops-static-web.git
```


### 4. Install the application dependencies with:
```
pip install -r requirements.txt
```

### 5. Gunicorn Configuration:

- Install Gunicorn in the virtual environment.
- Create a systemd service file for Gunicorn.
- Configure Gunicorn to serve the Flask application.

### 6. Nginx Installation and Configuration:

- Install Nginx on the Ubuntu server.
- Configure Nginx as a reverse proxy for Gunicorn.
- Ensure that Nginx is listening on port 80 and redirecting traffic to the Flask application.

### 7. Testing and Optimization:

- Verify that the application works correctly by accessing it from a web browser.
- Optimize the Nginx and Gunicorn configuration for better performance.

## My Solution

**1. Setted up Ubuntu ✅**

**2. Install Python 3, pip, and virtualenv  ✅**

   Update 
   ```
   sudo apt update
   ```

   Install dependencies
   ```
   sudo apt install python3 python3-pip
   ```

   Install virtualenv
   ```
   sudo apt install python3-venv
   ```

   Create a folder
   ```
   mkdir challenge01
   cd challenge01/
   ```

   Create a virtual env
   ```
   python3 -m venv venv
   ```

   Activate the virtual env
   ```
   source venv/bin/activate
   ```

   Update pip in the virtual env
   ```
   pip install --upgrade pip
   ```

   Install Flask
   ```
   pip install Flask
   ```

   
 **3. Application Deployment  ✅**
```
git clone -b booklibrary https://github.com/roxsross/devops-static-web.git
```

Install the dependencies
```
cd devops-static-web
pip install -r requirements.txt
```



### DEBUGGING 🥷👩🏽‍💻🙌   ✅

When I tried to run the Flask application to check that it is working I encountered an issue: 
```python library_site.py```

<img width="922" alt="Screenshot 2024-10-03 at 7 50 24 PM" src="https://github.com/user-attachments/assets/9bea9555-e4ee-43fc-b688-8b0bc37aa2ff">


After conducting some research, I found [this post from stackoverflow](https://stackoverflow.com/questions/73999854/flask-error-runtimeerror-working-outside-of-application-context) and modified the library_site.py file to include the missing code.
```
nano library_site.py
```
 
**4. Install the application dependencies with:   ✅** 
Since the requirements.txt is inside devops-static-web directory, first I navgate to that directory and then install the dependencies:
```
cd devops-static-web
pip install -r requirements.txt
```

**5. Gunicorn Configuration:   ✅**

Install Gunicorn in the virtual environment
```
pip install gunicorn
```

Run Gunicorn to serve the Flask application:
```
gunicorn -b 0.0.0.0:8000 library_site:app
```

Create a systemd service file for Gunicorn
```
sudo nano /etc/systemd/system/challenge01.service
```
<img width="1134" alt="Screenshot 2024-10-03 at 10 57 36 PM" src="https://github.com/user-attachments/assets/e18ce035-a457-4e5a-8bb9-61e82c82c9e7">


Enable and start the service:
```
sudo systemctl daemon-reload
sudo systemctl start challenge01
sudo systemctl enable challenge01
```
<img width="1178" alt="Screenshot 2024-10-03 at 11 01 13 PM" src="https://github.com/user-attachments/assets/0f0a8ee5-a3fb-4c2c-ab33-ca0d25f4cb24">

Check if the application is running with:
```
curl localhost:8000
```

<img width="1174" alt="Screenshot 2024-10-03 at 11 04 30 PM" src="https://github.com/user-attachments/assets/f31a30ff-7f9a-493e-ab7c-f0f569ab1032">


**6. Nginx Installation and Configuration:   ✅**

##### Configure Nginx as a reverse proxy for Gunicorn

Install Nginx on the Ubuntu server
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

Ensure that Nginx is listening on port 80 and redirecting traffic to the Flask application:
```
upstream flaskchallenge01 {
    server 127.0.0.1:8000;
}
```

Add a proxy_pass to flaskchallenge01 in the location/:
```
location / {
    proxy_pass http://flaskchallenge01;
}
```

<img width="1109" alt="Screenshot 2024-10-03 at 11 12 22 PM" src="https://github.com/user-attachments/assets/372e0ad3-3530-469f-aef0-2fb5ea14a8bc">


Restart Nginx for the changes to take effect:
```
sudo systemctl restart nginx
```


**7. Testing and Optimization:   ✅**

Verify that the application works correctly by accessing it from a web browser to ```http://localhost:8000/```:
<img width="1183" alt="Screenshot 2024-10-03 at 11 18 21 PM" src="https://github.com/user-attachments/assets/3bbc56d0-083c-4a3d-b04a-8bf4a61f6b65">


Optimize the Nginx and Gunicorn configuration for better performance:

_Gunicorn Performance Optimizations_
After doing some research, there are a few key settings when setting up Gunicorn I can tweak to get better performance based on the app's needs. 
I am able to adjust how the server behaves using command-line options. 

- Worker Processes: Running multiple worker processes is essential for handling requests in parallel. A good rule of thumb is to set the number of workers to (2 * number_of_cpus) + 1.
  - This helps your app manage more requests simultaneously and make the most of your CPU power.
  - 2 × number_of_cpus: This part suggests that for each CPU core, you should allocate two worker processes.
  - This approach allows the server to take advantage of both the CPU's ability to handle tasks and the potential waiting time for I/O operations.

- Threads: If your app deals with a lot of I/O or blocking operations, adding more threads per worker can boost performance. You can use the --threads option to spin up multiple threads inside each worker process.

- Gunicorn Settings: Some settings are crucial, like bind, log-level, and worker-class. Here's an example of how you could configure Gunicorn to run a Flask app:

Here are some key configurations I implemented:
```
gunicorn --workers=3 --threads=2 --worker-class=gthread --bind 0.0.0.0:8000 --log-level=info library_site:app
```

This command sets up Gunicorn with 3 worker processes, each with 2 threads, using the gthread worker class. 
It also binds the server to all interfaces on port 8000, and sets the logging level to 'info', providing a decent amount of detail in logs.


Also, using asynchronous workers like gevent can vastly improve performance for I/O-bound applications:
```
gunicorn --workers 4 --worker-class gevent library_site:app
```

Workers and Workers Class: The number of worker processes for handling requests should generally be in the range of 2-4 x $(num_cores) where $(num_cores) is the number of CPU cores on your server. Also, using asynchronous workers like gevent can vastly improve performance for I/O-bound applications.

Timeouts and Keep-Alive: It's important to adjust the timeout settings according to your application's characteristics. Longer timeouts might be necessary for long-running requests. Also, consider setting the keep-alive directive to a reasonable value to reduce the load on establishing TCP connections.
```
gunicorn --timeout 120 --keep-alive 5 library_site:app
```


_NGINX Performance Optimizations_

Chaching: Set up caching for static files to decrease latency and reduce load on your Flask application.
```
location /static/ {
    alias /home/laura/challenge01/devops-static-web/static;
    expires 30d;
    add_header Pragma public;
    add_header Cache-Control "public";
}
```

Buffer Sizes: Appropriately setting buffer sizes can help manage large client requests and responses efficiently.
```
client_body_buffer_size 10K;
client_max_body_size 8m;
client_header_buffer_size 1k;
large_client_header_buffers 4 4k;
```




 
