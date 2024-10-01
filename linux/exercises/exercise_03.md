# Exercise 03

## Installation of the LAMP Stack (Linux, Apache, MySQL, PHP) in Ubuntu

### 1. Apache Installation
Update

```
sudo apt update
```

Install Apache 

```
sudo apt install apache2 -y
```

Enable and start the Apache service
```
sudo systemctl enable apache2
sudo systemctl start apache2
```

<img width="856" alt="Screenshot 2024-09-02 at 10 16 08 AM" src="https://github.com/user-attachments/assets/9b0a7ac5-3b76-41d4-8b8e-1b7af750a905">

### 2. Install MySQL

```
sudo apt install -y mysql-server
```

Enable and restart MySQL server
```
sudo systemctl enable mysql
sudo systemctl start mysql
```
Access mysql
ِرشد
```
sudo mysql
```

Change the root user's authentication method to use a password

```
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```
_Breakdown of the Command_:
ALTER USER: This is a MySQL statement used to modify an existing user account.

'root'@'localhost': This specifies the MySQL user account being altered.

root: The username of the MySQL account.
localhost: Specifies that this user can only connect from the local machine (localhost). This means the root user can't connect remotely with these credentials.
IDENTIFIED WITH mysql_native_password: This clause sets the authentication method for the user.

mysql_native_password: Specifies that the mysql_native_password authentication plugin should be used. This is the traditional MySQL password authentication method.
BY 'password': This sets the new password for the user.

'password': This is a placeholder for the actual password you want to set. Replace 'password' with your desired password.
What the Command Does:
Changes the authentication method: It sets the root user to authenticate using the mysql_native_password plugin, which is MySQL's older and more widely compatible authentication method.

Sets a new password: The command updates the password for the root user to whatever you specify in the 'password' part of the command.


Exit the SQL prompt
```
exit
```


Run the MySQL security script

```
sudo mysql_secure_installation
```
<img width="994" alt="Screenshot 2024-09-02 at 11 31 13 AM" src="https://github.com/user-attachments/assets/be3c12a2-5211-4d75-8963-7f094ee3e4b8">


### 3. Install PHP
```
sudo apt install -y php libapache2-mod-php php-mysql
```

Restart apache
```
sudo systemctl restart apache2
```

### 4. Verify installation

I'll create a test file to verify the PHP configuration. I'll open a new file in the default web directory:

```
sudo nano /var/www/html/info.php
```

Added the following content:
```
<?php
phpinfo();
?>
```

CTRL + O saves a Nano file

CTRL + X exits Nano

Access from browser:
```
http://localhost/info.php
```
<img width="1159" alt="Screenshot 2024-09-02 at 11 39 02 AM" src="https://github.com/user-attachments/assets/9cdbcc94-a01a-494b-b3c4-8848b3ce2ca0">

**5. Test the Connection to the Database from PHP**
To verify the database connection from PHP, I'll create a test database and user in MySQL:

```
mysql -u root -p
```

_The command mysql -u root -p is used to connect to a MySQL database from the command line. Here’s what each part of the command does_:

**mysql**: This is the MySQL command-line client program, which allows you to interact with the MySQL server.

**-u root**: The -u option specifies the username you want to connect with. In this case, root is the username. The root user is typically the default administrative account in MySQL, with full privileges to manage the database.

**-p**: This option tells the MySQL client to prompt you for the password of the specified user (root in this case). After entering this command, you'll be prompted to enter the password associated with the root account. The -p flag doesn't require any password to be typed directly after it; in fact, it's a security practice not to include the password directly in the command line.

<img width="811" alt="Screenshot 2024-09-03 at 11 24 31 AM" src="https://github.com/user-attachments/assets/92a65a9b-74c3-4e11-88af-1647d7d910a8">


Create a database and a user:
```
CREATE DATABASE example_database;
CREATE USER 'example_user'@'%' IDENTIFIED BY 'password';
GRANT ALL ON example_database.* TO 'example_user'@'%';
```

Exit mysql console
```
exit
```

Test if the new user has the proper permissions, log in as the test user:
```
mysql -u example_user -p
```

Check if the database exists:
```
mysql> SHOW DATABASES; 
```
<img width="624" alt="Screenshot 2024-09-03 at 12 11 58 PM" src="https://github.com/user-attachments/assets/1433c2d0-b905-4f92-ba69-9736f3c2d36c">

Create a table named todo_list
```
mysql> CREATE TABLE example_database.todo_list (
mysql>  item_id INT AUTO_INCREMENT,
mysql>  content VARCHAR(255),
mysql>  PRIMARY KEY(item_id)
mysql> );
```


Insert test items

```
INSERT INTO example_database.todo_list (content) VALUES ("My first important item");
```

Check if data is saved successfully

```
SELECT * FROM example_database.todo_list;
```


<img width="588" alt="Screenshot 2024-09-03 at 12 41 21 PM" src="https://github.com/user-attachments/assets/05b890a6-9d6a-494d-9ad9-46b96c205ac6">


Create a PHP file to connect with MySQL and query data. Open a new file:
```
sudo nano /var/www/html/todo_list.php
```

Exit mysql command line
```
exit
```



Add the following to the todo_list.php file and replace the values user and password:
```
<?php
$user = "example_user";
$password = "password";
$database = "example_database";
$table = "todo_list";

try {
  $db = new PDO("mysql:host=localhost;dbname=$database", $user, $password);
  echo "<h2>TODO</h2><ol>";
  foreach($db->query("SELECT content FROM $table") as $row) {
    echo "<li>" . $row['content'] . "</li>";
  }
  echo "</ol>";
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>
```

In todo_list.php

<img width="886" alt="Screenshot 2024-09-03 at 12 42 43 PM" src="https://github.com/user-attachments/assets/7390e0dd-85d3-4abb-af6f-80c10e63d0bf">

