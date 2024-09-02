### Exercise 01

#### Deploying a hello world on a server

Deploying an HTML page is simple on a web server.


**Update system**

```
sudo apt update
```

**Install Apache**
```
sudo apt install apache2 -y
```

**Verify Apache Installation**
```
sudo systemctl status apache2
```
<img width="813" alt="Screenshot 2024-09-02 at 9 03 38 AM" src="https://github.com/user-attachments/assets/7ec120e0-0bcf-4b33-bad6-508a8035bae6">


**Navigate to docs directory Apache**
```
cd /var/www/html
```

**Create an HTML Page**
```
sudo nano index.html
```

**Modify the index.html content**
Delete everything with

```
CTRL + Shift + 6
```
And then 
```
CTRL + K
```
<img width="1021" alt="Screenshot 2024-09-02 at 9 14 25 AM" src="https://github.com/user-attachments/assets/d8389249-8045-40a6-aa1b-e59723d16cb6">

Save the changes
```
CTRL X + Y + Enter
```

Verify Permissions
```

```

_Here's a breakdown of the command_:

**sudo**: Runs the command with superuser (root) privileges. This is often used when you need to change permissions on a file that you don't own or to ensure that the command has the necessary permissions to execute.

**chmod**: Stands for "change mode" and is used to change the permissions of a file or directory.

**644**: This is the permission setting being applied to the file. It breaks down as follows:

**6**: The owner of the file has read and write permissions (4 + 2 = 6).
**4**: The group associated with the file has read-only permissions.
**4**: Others (everyone else) have read-only permissions.
**index.html**: The file to which the permissions are being applied.

**Resulting Permissions**:
After running sudo chmod 644 index.html, the permissions of index.html would be:

Owner: Read and write (rw-).
Group: Read-only (r--).
Others: Read-only (r--).

**Verify deployment**
<img width="1468" alt="Screenshot 2024-09-02 at 9 21 17 AM" src="https://github.com/user-attachments/assets/22b9af1d-8977-499d-938d-71b1f401f83d">


