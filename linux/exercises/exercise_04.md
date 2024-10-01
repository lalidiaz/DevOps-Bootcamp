# Exercise 04

## Deployment of an e-Commerce Application
I will learn how to deploy an e-commerce application using MariaDB and Apache with PHP. I will follow these steps to set up my environment and get my application running.

**Update**

```
sudo apt update
```


### Deployment and Configuration of the Database

#### 1. Install MariaDB
```
sudo apt install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo systemctl status mariadb
```
<img width="802" alt="Screenshot 2024-10-01 at 4 16 51 PM" src="https://github.com/user-attachments/assets/5a707674-fe9f-4bf7-887a-5d734343791d">

#### 2. Configure MariaDB
Access the MariaDB console and configure the database and the user:
```
sudo mysql
```
<img width="803" alt="Screenshot 2024-10-01 at 4 17 19 PM" src="https://github.com/user-attachments/assets/6697d96a-0e88-43ba-a653-f1bc210ef836">



 Inside MariaDB console:

```
CREATE DATABASE ecomdb;
CREATE USER 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword';
GRANT ALL PRIVILEGES ON ecomdb.* TO 'ecomuser'@'localhost';
FLUSH PRIVILEGES;
```


#### 3. Add data to the data base
Create a script file to load the initial data into the database

```
cat > db-load-script.sql <<-EOF
USE ecomdb;
CREATE TABLE products (
  id MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  Name VARCHAR(255) DEFAULT NULL,
  Price VARCHAR(255) DEFAULT NULL,
  ImageUrl VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
) AUTO_INCREMENT=1;

INSERT INTO products (Name, Price, ImageUrl) VALUES
  ("Laptop", "100", "c-1.png"),
  ("Drone", "200", "c-2.png"),
  ("VR", "300", "c-3.png"),
  ("Tablet", "50", "c-5.png"),
  ("Watch", "90", "c-6.png"),
  ("Phone Covers", "20", "c-7.png"),
  ("Phone", "80", "c-8.png"),
  ("Laptop", "150", "c-4.png");
EOF
```

Run the SQL script to load the data into the database:
```
mysql < db-load-script.sql
```


### Deployment and Configuration of the Web Server

#### 1. Install packages
```
sudo apt install -y apache2 php libapache2-mod-php php-mysql
```

#### 2. Start an Apache Web Server
```
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl status apache2
```
<img width="803" alt="Screenshot 2024-10-01 at 4 57 36 PM" src="https://github.com/user-attachments/assets/6628e791-91e1-4b6f-9ffc-3f8fedd50448">


#### 3. Configure the Application Code
Clone the e-commerce application repository and copy the files to the root of the web server:

```
     sudo apt install git -y
```

```
   git clone -b ecommerce https://github.com/roxsross/devops-static-web.git
 
```
<img width="811" alt="Screenshot 2024-10-01 at 5 00 44 PM" src="https://github.com/user-attachments/assets/54b3b963-ea26-45e0-9d62-2b72db449a5c">

```
    cp -r devops-static-web/app-ecommerce/* /var/www/html/
     mv /var/www/html/index.html /var/www/html/index.html.bkp
```

#### 4.Update index.php file
Modify index.php to point to the new database host:
```
sudo sed -i 's/172.20.1.101/localhost/g' /var/www/html/index.php
```

Make sure that the index.php file contains the following:
```
<?php
$link = mysqli_connect('localhost', 'ecomuser', 'ecompassword', 'ecomdb');
if ($link) {
  $res = mysqli_query($link, "SELECT * FROM products;");
  echo "<h2>Products</h2><ul>";
  while ($row = mysqli_fetch_assoc($res)) {
    echo "<li>" . $row['Name'] . " - $" . $row['Price'] . "</li>";
  }
  echo "</ul>";
} else {
  echo "Error connecting to the database.";
}
?>
```

Check the contents of index.php
<img width="810" alt="Screenshot 2024-10-01 at 5 08 23 PM" src="https://github.com/user-attachments/assets/a7e4d661-1d64-4f43-a17c-8148fab1b116">



<img width="1323" alt="Screenshot 2024-10-01 at 5 12 13 PM" src="https://github.com/user-attachments/assets/6a00efc5-b047-40ad-8bb8-43b8251d0902">
As you can see, the content of the index.php is not the one mentioned above, I am going to proceed to modify the file
<img width="640" alt="Screenshot 2024-10-01 at 5 18 14 PM" src="https://github.com/user-attachments/assets/37d00c63-68f4-4742-a42f-dccd5ba48d8a">

<img width="1002" alt="Screenshot 2024-10-01 at 5 19 02 PM" src="https://github.com/user-attachments/assets/a55d8d54-cc33-4dac-9d49-63958137ba7d">

#### 5. Verify Deployment
Make sure that the application is working correctly by accessing the following URL in your browser:
```
curl http://localhost
```


### DEBUGGING
I encountered an issue where I couldn't see the deployed application on localhost, so I followed these steps to debug the problem.


#### ✅ Check if Apache is Running

```
sudo systemctl status apache2
```
<img width="1176" alt="Screenshot 2024-10-01 at 5 28 16 PM" src="https://github.com/user-attachments/assets/f0e59cf4-fbf6-48c8-9461-7b4d0701a0d2">

#### ✅ Check Apache Configuration File
Make sure that Apache is configured to serve files from the correct directory. It should be set to serve from /var/www/html/, where you copied your application files.
You can check the configuration in the main Apache configuration file:
```
cat /etc/apache2/sites-available/000-default.conf
```
<img width="987" alt="Screenshot 2024-10-01 at 5 31 04 PM" src="https://github.com/user-attachments/assets/bf4f13ab-a462-44a0-bc2a-5a9a6694a74c">

Ensure that the DocumentRoot line points to /var/www/html.


#### ✅ Check File Permissions
Ensure that the files in /var/www/html/ have the correct permissions. You can adjust the permissions with the following commands:
```
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
```


#### ✅ Verify index.php Configuration
Make sure that the index.php file is present in /var/www/html/ and contains the correct PHP code. You can check it using nano or cat:
```
nano /var/www/html/index.php
```

#### ✅ Test Database Connection
From the Ubuntu command line, you can test if you can connect to the database using the credentials you used in index.php:
```
mysql -u ecomuser -p
```

Enter the password ecompassword and verify that you can access the ecomdb database and that the products table has data.

#### ✅ Test in a Web Browser
```
curl http://localhost

```

<img width="1009" alt="Screenshot 2024-10-01 at 5 47 21 PM" src="https://github.com/user-attachments/assets/53037bd5-9006-4bd5-8c4d-0e88ef970da9">


### E-Commerce successfully deployed✨🎉 
In conclusion, the deployment issue with the e-commerce application was due to incorrect indentation in the PHP file, resulting in syntax errors. There were also unnecessary PHP tags that complicated things further. After fixing the indentation and removing the extra tags, the application worked correctly, allowing me to access it through the web server without any issues.

<img width="1366" alt="Screenshot 2024-10-01 at 5 48 08 PM" src="https://github.com/user-attachments/assets/714c0e51-be3b-4861-95fb-1c760d2906f2">
