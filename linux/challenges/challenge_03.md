# Challenge 03

## Linux Exercise for DevOps
Are you new to Linux? This exercise covers all the basic concepts necessary to familiarize yourself with Linux as a DevOps professional.

### Linux Skills
To complete this exercise, the following skills are required:

- User Management in Linux
- Permissions
- Directory Structure
- File Systems
- File Management

**Prerequisites:** Log in to your Ubuntu server (or similar distribution) to complete the following exercise.

### Deployment
1. Log in to the server as a superuser and perform the following tasks:

- Create users and set passwords: user1, user2, user3
- Create groups: devops, aws
- Change the primary group of user2 and user3 to the ‘devops’ group
- Add the ‘aws’ group as a secondary group to ‘user1’
- Create the specified file and directory structure
- Change the group of ```/dir1```, ```/dir7/dir10```, and ```/f2``` to the "devops" group
- Change the ownership of ```/dir1```, ```/dir7/dir10```, and ```/f2``` to the user “user1”

2. Log in as user1 and perform the following tasks:

- Create users and set passwords: user4, user5
- Create groups: app, database

3. Log in as ‘user4’ and perform the following tasks:

- Create directory: ```/dir6/dir4```
- Create file: ```/f3```
- Move the file from "/dir1/f1" to "/dir2/dir1/dir2"
- Rename the file ‘/f2’ to ‘/f4’

4. Log in as ‘user1’ and perform the following tasks:

- Create directory: ```/home/user2/dir1```
- Change to the directory "/dir2/dir1/dir2/dir10" and create the file "/opt/dir14/dir10/f1" using the relative path method.
- Move the file from "/opt/dir14/dir10/f1" to user1's home directory
- Recursively delete the directory "/dir4"
- Delete all files and directories under "/opt/dir14" using a single command
- Write the text "Linux assessment for a DevOps Engineer!! Learn with Fun!!" in the file /f3 and save it

5. Log in as ‘user2’ and perform the following tasks:

- Create file: ```/dir1/f2```
- Delete ```/dir6```
- Delete ```/dir8```
- Replace the text “DevOps” with “devops” in the file ```/f3``` without using an editor
- Using Vi Editor, copy line 1 and paste it 10 times in the file ```/f3```
- Search for the pattern “Engineer” and replace it with “engineer” in the file ```/f3``` using a single command
- Delete ```/f3``


6. Log in as ‘root’ and perform the following tasks:

- Search for the file ‘f3’ on the server and list all absolute paths where the file f3 is located
- Show the file count in the directory ‘/’
- Print the last line of the file ‘/etc/passwd’
- Create a filesystem on a new simulated EBS volume and mount it to the directory /data
- Check the filesystem usage using ‘df -h’
- Create a file ‘f1’ in the filesystem ```/data```


7. Log in as ‘user5’ and perform the following tasks:

- Delete ```/dir1```
- Delete ```/dir2```
- Delete ```/dir3```
- Delete ```/dir5```
- Delete ```/dir7```
- Delete ```/f1``` and ```/f4```
- Delete ```/opt/dir14```


8. Log in as ‘root’ and perform the following tasks:

- Delete users: ```user1, user2, user3, user4, user5```
- Delete groups: app, aws, database, devops
- Delete the home directories of all users if they still exist
- Unmount the filesystem /data
- Delete the directory /data

# My Solution 🙌👩🏽‍💻✅🎉

## Log in to the server as a superuser and perform the following tasks 

**Create users: user1, user2, user3  ✅** 

```
sudo useradd user1
sudo useradd user2
sudo useradd user3`
```

**Set passwords ✅**  

```
sudo passwd user1
sudo passwd user2
sudo passwd user3
```

To check if the users were created, I use the ```tail /etc/passwd``` command to bring the most recent entries:
<img width="625" alt="Screenshot 2024-10-06 at 1 22 38 PM" src="https://github.com/user-attachments/assets/98e2cf44-99de-46cf-9c92-4e7e64326674">


**Create groups: devops, aws  ✅**

```
sudo groupadd devops && sudo groupadd aws
```

To check if the groups were created, I check with 

```cat /etc/group```


<img width="496" alt="Screenshot 2024-10-06 at 1 21 04 PM" src="https://github.com/user-attachments/assets/ac4f5f19-564b-4d1e-b86f-de303d149c32">


**Change the primary group of user2 and user3 to the "devops" group ✅**

```
sudo usermod -g devops user2
```

```
sudo usermod -g devops user3
```

To verify the changes, I use the id command:

```
id user2

```

```
id user3
```

<img width="909" alt="Screenshot 2024-10-06 at 1 31 14 PM" src="https://github.com/user-attachments/assets/d69ae123-1a99-4fe7-8734-cbcdd2ae40b4">

This will show you the user's UID, primary GID (which should now be the GID of the "devops" group), and all group memberships.



**Add the "aws" group as a secondary group to "user1" ✅**

```
sudo usermod -aG aws user1
```

<img width="658" alt="Screenshot 2024-10-06 at 1 34 02 PM" src="https://github.com/user-attachments/assets/537e0fdd-cc5e-4028-914c-0be87d9f5191">



**Create the specified file and directory structure ✅**

```
mkdir dir1 -p dir7/dir10 f2
```

<img width="1294" alt="Screenshot 2024-10-06 at 1 43 18 PM" src="https://github.com/user-attachments/assets/be444785-e95e-48b3-9e6d-2d19bbc43e50">



**Change the group of /dir1, /dir7/dir10, and /f2 to the "devops" group ✅**

```
sudo chgrp devops dir7
sudo chgrp devops dir7/dir10
sudo chgrp devops f2
```

<img width="790" alt="Screenshot 2024-10-06 at 1 51 59 PM" src="https://github.com/user-attachments/assets/bdef342b-754c-4fcc-a959-1f583c8d6dd5">



**Change the ownership of /dir1, /dir7/dir10, and /f2 to the user "user1" ✅**

```
sudo chown user1 /dir1 /dir7/dir10 /f2
```


## Log in as user1 and perform the following tasks:

```
su user1
```

<img width="595" alt="Screenshot 2024-10-06 at 1 58 38 PM" src="https://github.com/user-attachments/assets/e303de15-132a-4e67-ad44-685fc5937aa3">


**Create users and set passwords: user4, user5 ✅**

```
sudo adduser user4
```

While trying to execute the prev command, I got the following error:
<img width="479" alt="Screenshot 2024-10-06 at 8 48 19 PM" src="https://github.com/user-attachments/assets/59397b04-0774-4c8b-84b4-dcab90fa49f1">

This error means that user1 doesn't have the necessary permissions to use sudo and perform administrative tasks like creating new users.

To solve this, I added user1 to the sudoers file: This needs to be done by root or a user with sudo privileges. 

```
usermod -aG sudo user1
```


Run this command to create users and passowrds for user4 and user5: 

```
sudo useradd user4
sudo passwd user4

sudo useradd user5
sudo passwd user5
```

**Create groups: app, database ✅**

```
sudo groupadd app && sudo groupadd database
```

<img width="758" alt="Screenshot 2024-10-06 at 8 55 58 PM" src="https://github.com/user-attachments/assets/55ca8ed1-dec9-46ac-aa18-283ef779b85e">

## Log in as ‘user4’ and perform the following tasks:

```
su user4
```


**Create directory: /dir6/dir4 ✅** 

Add user to sudoers file:

```
exit
usermod -aG sudo user4
```

```
mkdir -p dir6/dir4
```

**Create file: /f3 ✅**

```
sudo touch /f3
```

<img width="912" alt="Screenshot 2024-10-06 at 9 32 47 PM" src="https://github.com/user-attachments/assets/30a9cbd0-971b-439f-accc-01af63d4e155">

**Move the file from "/dir1/f1" to "/dir2/dir1/dir2" ✅** 

Create file f1 inside dir1:

```
sudo touch f1
```

Create ```/dir2/dir1/dir2```


```
sudo mkdir -p dir2/dir1/dir2
```

<img width="766" alt="Screenshot 2024-10-06 at 9 45 35 PM" src="https://github.com/user-attachments/assets/f452480b-1193-4e33-af87-9469290c1d0f">


**Rename the file ‘/f2’ to ‘/f4’ ✅**

Create file f2:

```
sudo touch f2
```

Rename it:

```
sudo mv /f2 /f4
```

## Log in as ‘user1’ and perform the following tasks:

**Create directory: /home/user2/dir1  ✅** 

```
sudo mkdir /home/user2/dir1
```

**Change to the directory "/dir2/dir1/dir2/dir10" and create the file "/opt/dir14/dir10/f1" using the relative path method ✅**

Change to directory:

```
cd /dir2/dir1/dir2/dir10
```

Create directory:

```
sudo mkdir -p /opt/dir14/dir10
```

cd into the folder:

```
cd /dir2/dir1/dir2/dir10
```

Create file:

```
sudo touch ../../../../opt/dir14/dir10/f1
```

**Move the file from "/opt/dir14/dir10/f1" to user1's home directory ✅**

```
mv /opt/dir14/dir10/f1 ~
```

**Recursively delete the directory "/dir4" ✅**

```
rm -rf /dir4
```


**Delete all files and directories under "/opt/dir14" using a single command ✅**

```
rm -rf /opt/dir14/*
```

**Write the text "Linux assessment for a DevOps Engineer!! Learn with Fun!!" in the file /f3 and save it ✅**

Check the current permissions of the file /f3:

```
ls -l /f3
```

<img width="549" alt="Screenshot 2024-10-06 at 10 30 53 PM" src="https://github.com/user-attachments/assets/8f4dfde5-4e09-41ba-a363-afd6f282a100">

The file is owned by root, and my current user (user1) doesn't have the necessary permissions to write to it.

Modify File Permissions to Allow user1 to Write:

```
sudo chmod o+w /f3
```

Check the file with ```cat /f3```:


<img width="657" alt="Screenshot 2024-10-06 at 10 37 01 PM" src="https://github.com/user-attachments/assets/d566b933-c722-4d69-8773-9fa5ef20aa6f">


```
echo "Linux assessment for a DevOps Engineer!! Learn with Fun!!" > /f3
```

## Log in as ‘user2’ and perform the following tasks:

**Create file: /dir1/f2 ✅**

```
su user2
whoami
```

<img width="492" alt="Screenshot 2024-10-06 at 10 40 46 PM" src="https://github.com/user-attachments/assets/c3eb4d2a-a8ba-44af-8852-e9abc396dc31">

Add user to sudoers file:

```
usermod -aG sudo user2
```


Create file:

```
sudo touch /dir1/f2
```

**Delete /dir6 ✅**

```
sudo rm -r dir6
```

**Delete /dir8 ✅**

```
sudo rm -r dir8
```

**Replace the text “DevOps” with “devops” in the file /f3 without using an editor ✅**

Check File Permissions:

```
ls -l /f3
```

Replace the text without an editor: 

```
sudo sed -i 's/DevOps/devops/g' /f3
```

**Using Vi Editor, copy line 1 and paste it 10 times in the file /f3 ✅**

```
sudo vi /f3
```
# Inside vi editor:
1. Press `yy` on the first line to copy it
2. Press `10p` to paste it 10 times
Save and exit (press `:wq`).

<img width="677" alt="Screenshot 2024-10-06 at 11 06 15 PM" src="https://github.com/user-attachments/assets/db78cb0e-6632-4c55-92c0-c500ff6450a0">


**Search for the pattern “Engineer” and replace it with “engineer” in the file /f3 using a single command ✅** 

To replace "Engineer" with "engineer", run:

```
sudo vi /f3
sed -i 's/Engineer/engineer/g' /f3
```


**Delete ```/f3``` ✅**

```
sudo rm /f3
```


## Log in as ‘root’ and perform the following tasks:

**Search for the file ‘f3’ on the server and list all absolute paths where the file f3 is located: ✅**

```
find / -name f3
```


**Show the file count in the directory ‘/’ ✅**

```
find / -type f | wc -l
```

<img width="350" alt="Screenshot 2024-10-06 at 11 12 22 PM" src="https://github.com/user-attachments/assets/5ab00d1d-9039-4b9b-850d-b0c7ab8c2c82">


**Print the last line of the file ‘/etc/passwd’ ✅**

```
tail -n 1 /etc/passwd
```

<img width="572" alt="Screenshot 2024-10-06 at 11 13 25 PM" src="https://github.com/user-attachments/assets/50bec67e-4d95-423c-a937-e154100024f1">


**Create a file ‘f1’ in the filesystem /data ✅**

```
touch data/f1
```

## Log in as ‘user5’ and perform the following tasks:

Add user to sudoers file:

```
usermod -aG sudo user5
```


**Delete /dir1,  /dir2, /dir3 , /dir5, /dir7 , /f1 and /f4 /opt/dir14 ✅**

```
sudo rm -rf /dir1 /dir2 /dir3 /dir5 /dir7 /f1 /f4 /opt/dir14
```

## Log in as ‘root’ and perform the following tasks:

**Delete users: user1, user2, user3, user4, user5 | Delete groups: app, aws, database, devops | Delete the home directories of all users if they still exist  | ✅**

```
sudo userdel -r user1 && sudo userdel -r user2 && sudo userdel -r user3 && sudo userdel -r user4 && sudo userdel -r user5 && sudo groupdel app && sudo groupdel aws && sudo groupdel database && sudo groupdel devops
```


**Unmount the filesystem /data ✅**

```
sudo umount /data
```

**Delete the directory /data ✅**

```
rm -rf /data
```
