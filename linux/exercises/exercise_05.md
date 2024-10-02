# Exercise 05

## Installing Jenkins for CI/CD
Jenkins is an open source automation tool widely used to manage repetitive tasks in software development, such as build and deployment. Based on Java, Jenkins can be installed using Ubuntu packages or by running its Web Application Archive (WAR) file.


### Install Java
```
sudo apt install default-jre
```

### 1. Install Jenkins [Docs](https://www.jenkins.io/doc/book/installing/linux/)
```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```

**Add the Jenkins repository**
```
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
```

**Start Jenkins**
```
sudo systemctl start jenkins
```


### 2. Start Jenkins
Verify that Jenkins is working correctly with:
```
sudo systemctl status jenkins
```
<img width="822" alt="Screenshot 2024-10-02 at 7 26 59 AM" src="https://github.com/user-attachments/assets/d0a0cf5c-a352-4057-a0d6-bbcea49f2cfc">

### 3. Configurate Jenkins
**Access the Jenkins web interface**
Visit http://your_server_or_domain:8080 in your browser. You should see the 'Unlock Jenkins' screen.

<img width="1827" alt="Screenshot 2024-10-02 at 7 29 13 AM" src="https://github.com/user-attachments/assets/d366b911-6821-4230-b96a-caedf4aa8394">

#### Obtain the initial password
Show current password:
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
<img width="772" alt="Screenshot 2024-10-02 at 7 30 38 AM" src="https://github.com/user-attachments/assets/80e510cb-f048-4f8c-a8eb-0a7c4f916dac">

#### Copy password and paste it in initialAdminPassword
<img width="1830" alt="Screenshot 2024-10-02 at 7 36 58 AM" src="https://github.com/user-attachments/assets/7d7c80a8-d93c-426b-ba30-eff9e9a96892">


#### Install Plugins
<img width="421" alt="Screenshot 2024-10-02 at 7 40 35 AM" src="https://github.com/user-attachments/assets/3a47e35c-86ce-4d8b-b8d7-c876ed890673">
<img width="1829" alt="Screenshot 2024-10-02 at 7 40 58 AM" src="https://github.com/user-attachments/assets/537a9710-6e22-4236-abd1-912aa73c85d1">

#### Create the first admin user
After installing the plugins, you can create an admin user or continue as admin using the initial password.

#### Configure the Jenkins instance
Confirm your instance's URL and save the changes. You should see a confirmation screen with the message 'Jenkins is Ready!'
<img width="1831" alt="Screenshot 2024-10-02 at 7 46 14 AM" src="https://github.com/user-attachments/assets/7ebfad2a-f7fe-4d8c-9f7a-9be28ab1316e">

