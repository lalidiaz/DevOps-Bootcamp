# Exercise 08

## Installing Nginx
Nginx is one of the most popular web servers in the world and is responsible for hosting some of the largest and highest-traffic sites on the internet. It is a lightweight option that I can use both as a web server and a reverse proxy.

In this guide, I will discuss how to install Nginx on my Ubuntu server, adjust the firewall, manage the Nginx process, and configure server blocks to host multiple domains from a single server.

I will deploy my applications from GitHub using DigitalOcean App Platform. I will let DigitalOcean handle scaling my application.

### Prerequisites
Before I begin this guide, I need to have a regular user (not root) with sudo privileges set up on my server. I can learn how to set up a regular user account by following the initial server setup guide for Ubuntu 22.04.

It is also optional for me to register a domain name before completing the final steps of this tutorial. To learn more about how to set up a domain name with DigitalOcean, I will check our Introduction to DigitalOcean DNS.

Once I have an available account, I will log in as my non-root user to get started.

#### How to Create a New Sudo User and Manage Sudo Access on Ubuntu 22.04: Steps I followed

The command following adds a new user "laura_test"
```
sudo adduser laura_test
```
<img width="716" alt="Screenshot 2024-10-02 at 2 15 02 PM" src="https://github.com/user-attachments/assets/6e8ee646-123a-4e70-9271-65cb79efc6c6">

Assigns the user to the administrators group:
```
sudo usermod -aG sudo laura_test
```


**To verify the User's Sudo Privileges** 

Switch to the new user:
```
su - laura_test
```

Test sudo access:
```
sudo whoami
```
<img width="727" alt="Screenshot 2024-10-02 at 2 25 24 PM" src="https://github.com/user-attachments/assets/5b0dff39-0605-4a08-a615-886c5390d478">

If the command returns root, the user has sudo privileges.


### 1. Install Nginx
Since Nginx is available in Ubuntu's default repositories, it can be installed from these repositories using the apt package management system.
```
sudo apt update
sudo apt install nginx
```

<img width="1373" alt="Screenshot 2024-10-02 at 2 27 40 PM" src="https://github.com/user-attachments/assets/58d9cf0c-aa1e-4fc7-9ce6-ab2da8b5059a">

### 2. Verify Web Server
At the end of the installation process, Ubuntu 22.04 starts Nginx. The web server should already be running.
I can verify this using the systemd initialization system to make sure the service is running by typing:

```
systemctl status nginx
```
## DEBUGGING 👩🏽‍💻🥷
I encountered the following issue and will be following a few steps to troubleshoot it:
<img width="1173" alt="Screenshot 2024-10-02 at 2 34 55 PM" src="https://github.com/user-attachments/assets/061a3738-96a1-4965-80e1-89cd7422c0c6">

##### a. I checked the logs and found out what the issue was (see 2nd screenshot)
<img width="959" alt="Screenshot 2024-10-02 at 2 36 00 PM" src="https://github.com/user-attachments/assets/add3e2fe-51e7-4044-b7ed-7672ad1a8a43">
<img width="1108" alt="Screenshot 2024-10-02 at 2 36 56 PM" src="https://github.com/user-attachments/assets/df637310-9bec-48ad-8f2b-27d19f46449b">


##### b.To find out which process is using port 80, run the following command:
```
sudo lsof -i :80
```
<img width="747" alt="Screenshot 2024-10-02 at 2 38 57 PM" src="https://github.com/user-attachments/assets/a534b7c7-f3a3-4bf8-b210-709e4bd2dd54">


##### c.Now I will stop the conflicting service:
```
sudo systemctl stop apache2
```


##### d.Restart NGINX
```
sudo systemctl restart nginx
```

#### PROBLEM FIXED 🎉✅
<img width="1232" alt="Screenshot 2024-10-02 at 2 42 29 PM" src="https://github.com/user-attachments/assets/8af60c63-8ed3-4b8b-89ec-58b02521c61b">



The output will confirm that the service has started successfully. However, the best way to test this is by requesting an Nginx page.

I can access the default Nginx welcome page to confirm that the software is working correctly by navigating to my server's IP address. 
If you don't know the server's IP address, you can find it using the tool icanhazip.com, which will give me your public IP address:
```
curl -4 icanhazip.com
```
<img width="1316" alt="Screenshot 2024-10-02 at 2 48 15 PM" src="https://github.com/user-attachments/assets/a278ccbd-c298-48e4-8210-7a4e09d24f3c">


### 3. Manage the Nginx Process
Now that I have my web server up and running, let's go over some basic management commands.


**Stop the web server:**

```
sudo systemctl stop nginx
```


**To start the web server when it is stopped**

```
sudo systemctl start nginx
```

**To stop and then start the service again**

```
sudo systemctl restart nginx
```

**If you are only making configuration changes, Nginx can often reload without closing the connections. To do this, type:**

```
sudo systemctl reload nginx
```

**By default, Nginx is configured to start automatically when the server boots up. If this is not what you want, you can disable this behavior by typing:**

```
sudo systemctl disable nginx
```

**To re-enable the service to start on boot, you can type:**

```
sudo systemctl enable nginx
```

