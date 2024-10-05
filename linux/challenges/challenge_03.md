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
