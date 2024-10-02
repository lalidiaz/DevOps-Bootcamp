# Exercise 07

## How to Deploy a Weather Application in React with PM2
I will learn to deploy a React application using PM2 to manage the process. This approach will allow me to keep my application running and make it easier to manage.

### 1.Update System
```
sudo apt update
```

### 2.Install Node.js y npm with NVM
Node Version Manager (NVM) makes it easy to manage multiple versions of Node.js. Follow these steps to install NVM and set up Node.js:

#### Instalar NVM:
Download and install NVM with the following command:
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
```

<img width="1327" alt="Screenshot 2024-10-02 at 8 09 48 AM" src="https://github.com/user-attachments/assets/a04b6394-922a-4e19-afe4-9861bc0bcc76">

#### Verify the Installation and List Available Versions:
Make sure that NVM is installed correctly and check the available versions of Node.js:
```
nvm help
nvm list-remote
```

<img width="1212" alt="Screenshot 2024-10-02 at 8 11 05 AM" src="https://github.com/user-attachments/assets/18e44b37-3af3-4fbc-a2e3-701fda53c06c">
<img width="1315" alt="Screenshot 2024-10-02 at 8 11 31 AM" src="https://github.com/user-attachments/assets/769a167a-4bb8-421d-9b3b-4f8c216b1663">


#### Install the Required Version of Node.js:
Install the specific version of Node.js that I need:

```
nvm install v20.16.0
```

<img width="1343" alt="Screenshot 2024-10-02 at 8 12 54 AM" src="https://github.com/user-attachments/assets/92c0725b-e2ba-4164-a814-d72b8edc2865">


#### Select the Version of Node.js to Use:
Select the version of Node.js that I just installed:
```
nvm use v20.16.0
```
<img width="1368" alt="Screenshot 2024-10-02 at 8 13 56 AM" src="https://github.com/user-attachments/assets/d6146868-a8c3-404e-adb5-f5470c19160f">


#### Verify the Installed Version:
Check that Node.js and npm are available:
```
nvm current
```
<img width="991" alt="Screenshot 2024-10-02 at 8 14 44 AM" src="https://github.com/user-attachments/assets/62c66282-1150-4d74-91b9-0d215a2cca7a">

### Clone Your Project
With Node.js and npm ready, it’s time to clone and set up my project.

#### weather-app Application (Port 3000):
```
git clone -b devops-weather-app https://github.com/roxsross/devops-static-web.git
cd devops-static-web
npm install
```

You can repeat this process to deploy more applications as needed


### Configure PM2
PM2 is a process manager for Node.js applications that makes it easy to keep applications running in the background and automatically restart them in case of failure.

#### Install PM2:
```
npm install pm2@latest -g
```
<img width="871" alt="Screenshot 2024-10-02 at 8 21 37 AM" src="https://github.com/user-attachments/assets/32d65efe-4217-418c-a229-5a75ec5d173e">

#### Verify PM2 Installation:
Make sure that PM2 is installed correctly:
```
pm2 list
```
<img width="1074" alt="Screenshot 2024-10-02 at 8 22 10 AM" src="https://github.com/user-attachments/assets/250cb1de-18b0-4693-8d45-631b930f152a">


#### Start the Application on Port 3000:
Start the weather-app and make sure it restarts automatically if it stops:
<img width="1306" alt="Screenshot 2024-10-02 at 8 23 11 AM" src="https://github.com/user-attachments/assets/2aadbf6a-fd08-480e-af32-2b8bb8699e53">


PM2 will ensure that your application continues running even if you close the terminal session, and the --watch flag will allow PM2 to monitor the files for changes.

### 🎉✅ Access the Application
Once I have configured PM2, I can access my application in the web browser.
Visit http://localhost:3000 to see my application in action.
<img width="1839" alt="Screenshot 2024-10-02 at 8 49 09 AM" src="https://github.com/user-attachments/assets/9476528b-c81d-4c5b-8ca5-b9ead98e36bc">



