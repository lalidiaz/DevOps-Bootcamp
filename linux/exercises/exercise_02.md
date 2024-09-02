### Exercise 02

#### Deploying a Mario Bross Game

I'll show how to clone a repository that contains a static Mario Bros game and deploy it on an Apache web server in Ubuntu.

**1. Update System**
```
sudo apt update
```

**2. Install Apache**
```
sudo apt install apache2 -y
```

**3. Verify Apache Installation**
```
sudo systemctl status apache2

```
<img width="1062" alt="Screenshot 2024-09-02 at 9 32 16 AM" src="https://github.com/user-attachments/assets/9aa3d9a0-ddf1-4d0e-a789-968bba00fc1d">

**4. Clone Repo**
Install Git
```
sudo apt install git -y
```

Clone repository
```
cd /var/www/html
sudo git clone -b devops-mariobros https://github.com/roxsross/devops-static-web.git
```
<img width="1175" alt="Screenshot 2024-09-02 at 9 39 40 AM" src="https://github.com/user-attachments/assets/fa805f80-9fe9-4233-b595-138375755e14">

**5. Configure Apache**
I can either set up a new Apache configuration file or use the default one. I'll use the default configuration file. 
I'll create a symbolic link to the cloned directory in Apache's web directory:

```
sudo ln -s /var/www/html/devops-static-web /var/www/html/mariobros
```

**6. Verify Permissions**
```
sudo chown -R www-data:www-data /var/www/html/devops-static-web
```

**7. Restart Apache**
```
sudo systemctl restart apache2
```

**8. Verify Website**

Navigate to: http://localhost/mariobros

<img width="1272" alt="Screenshot 2024-09-02 at 9 50 50 AM" src="https://github.com/user-attachments/assets/cf1cb9b4-6e5c-4a06-abfe-7a4f957c850a">

