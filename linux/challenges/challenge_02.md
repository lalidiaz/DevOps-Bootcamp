# Challenge 02

## Deployment of Applications with PM2
ZERO Technology has launched a new project that requires the deployment of multiple applications on a server. The goal is to deploy both the frontend and several backend services using PM2 to manage the processes. This challenge is designed to assess your skills in application deployment, environment configuration, and automation.

### Goals:
- Propose and implement a comprehensive solution to the problem.
- Simulate a real-case scenario for the application lifecycle.
- Automation is key.

### Services to Deploy:

**Frontend**
Description: Web application built with Express.
Port: 3000

**Backend Products**
Description: Backend service for products built with Express.
Port: 3001

**Backend Shopping-Cart**
Description: Backend service for the shopping cart built with Express.
Port: 3002

**Backend Merchandise**
Description: Backend service for merchandise built with Express.
Port: 3003


### Challenge Instructions:

**Server Preparation:**
- Ensure you have access to an Ubuntu server (or your chosen distribution).
- Update the system and prepare the server for the installation of necessary tools.

**Dependency Installation:**
- Install Node.js and npm if they are not already installed.
   - Node Version: 18
- Install PM2 globally:
  ```
  sudo npm install -g pm2
  ```

**Application Configuration:**
- Clone the repository:
```
git clone -b ecommerce-ms https://github.com/roxsross/devops-static-web.git
```

Repository Content Structure:
```
 ├── frontend
 │   ├── index.html
 │   ├── package-lock.json
 │   ├── package.json
 │   └── server.js
 ├── merchandise
 │   ├── package-lock.json
 │   ├── package.json
 │   └── server.js
 ├── products
 │   ├── package-lock.json
 │   ├── package.json
 │   └── server.js
 └── shopping-cart
     ├── package-lock.json
     ├── package.json
     └── server.js
```

- Navigate to each application's directory and install dependencies:
```
npm install
```

**Application Deployment:**

- Use PM2 to start each application.
- Verify that the applications are running:
```
pm2 list
```

**Web Server Configuration (Optional):**

- If you choose to set up a web server like Nginx to manage traffic, install and configure Nginx to redirect traffic to the applications:
```
sudo apt install nginx
```
- Configure the server blocks in Nginx to redirect traffic to the application ports.


**Automation and Monitoring:**

- Set up PM2 to automatically restart applications upon server reboot:
```
pm2 startup
```

- Save the current state of the applications so they restore upon server restart:
```
pm2 save
```

- Consider configuring monitoring tools to check the status and performance of the applications.

**Testing and Validation:**

- Verify that all applications are functioning correctly by accessing the specified ports from a web browser.
- Conduct functionality tests to ensure that services interact correctly.

**Expected Results**
- All applications should be deployed and running without issues.
- The setup should demonstrate effective use of PM2 for process management and automation.
- Users should be able to access the frontend and backend services seamlessly.

## My Solution

#### ✅ Server Preparation


#### ✅ Dependency Installation


**Check if I have node and npm installed:**

<img width="471" alt="Screenshot 2024-10-04 at 11 13 11 AM" src="https://github.com/user-attachments/assets/3280cd4c-807d-4f88-ae43-edfcad6a6df8">


**Install PM2**

```
npm install pm2@latest -g
```


**Verify installation**

```
pm2 list
```
<img width="1238" alt="Screenshot 2024-10-04 at 11 15 58 AM" src="https://github.com/user-attachments/assets/6becf36a-099d-488b-809a-1c3a36120d48">


#### ✅ Application Configuration


**Clone repository**

```
git clone -b ecommerce-ms https://github.com/roxsross/devops-static-web.git
```

<img width="924" alt="Screenshot 2024-10-04 at 11 18 37 AM" src="https://github.com/user-attachments/assets/eb7d2453-6069-4671-aa2d-7f595b8398b5">



**Navigate to each application's directory and install dependencies:**

<img width="1112" alt="Screenshot 2024-10-04 at 11 19 45 AM" src="https://github.com/user-attachments/assets/18c83cc3-8306-4b76-8f72-e652d9eb4f77">

<img width="691" alt="Screenshot 2024-10-04 at 11 20 05 AM" src="https://github.com/user-attachments/assets/4430d6ab-8e6c-491c-ab5e-454a46d6db69">

<img width="850" alt="Screenshot 2024-10-04 at 11 20 31 AM" src="https://github.com/user-attachments/assets/cc33d6ea-8188-4c54-a58a-2f6e8d43f28d">

<img width="792" alt="Screenshot 2024-10-04 at 11 29 17 AM" src="https://github.com/user-attachments/assets/7e17b950-5d35-4682-8ae9-53b0ea3d8563">


#### ✅ Application Deployment


**Use PM2 to start each application**

After researching and reviewing the  [documentation](https://pm2.keymetrics.io/docs/usage/application-declaration/), I realized that I need to create a configuration file to manage multiple applications with PM2.

To generate a sample configuration file:
```
pm2 init simple
```

This will generate a ```ecosystem.config.js``` file.

And I added the following:
```
module.exports = {
  apps : [
  {
      "name": "frontend",
      "script": "./frontend/server.js",
      "instances": 2,
      "exec_mode": "cluster",
      "env": {
        "PORT": "3000",
      }
    },
   {
      "name": "products",
      "script": "./products/server.js",
      "instances": 1,
      "exec_mode": "fork",
      "env": {
        "NODE_ENV": "productsEndpoint",
        "PORT": "3001",
      }
    },
   {
      "name": "shopping-cart",
      "script": "./shopping-cart/server.js",
      "instances": 1,
      "exec_mode": "fork",
      "env": {
        "NODE_ENV": "shoppingCartEndpoint",
        "PORT": "3002",
      }
    },
    {
      "name": "merchandise",
      "script": "./merchandise/server.js",
      "instances": 1,
      "exec_mode": "fork",
      "env": {
        "NODE_ENV": "merchandiseEndpoint",
        "PORT": "3003",
      }
    } 
  ]
}

```

Start all the applications:
```
pm2 start ecosystem.config.js
```
<img width="1523" alt="Screenshot 2024-10-05 at 8 47 17 PM" src="https://github.com/user-attachments/assets/0b5fb9dd-7ab8-4f55-95e7-510653a66d29">


#### ✅ Automation and Monitoring


**Set up PM2 to automatically restart applications upon server reboot:**

After reviewing the [documentation](https://pm2.keymetrics.io/docs/usage/startup/), I found that 'PM2 can generate startup scripts and configure them to keep your process list intact across both expected and unexpected machine restarts.

To automatically generate and configuration a startup script just type the command (without sudo) pm2 startup:
```
pm2 startup
```
<img width="706" alt="Screenshot 2024-10-05 at 9 05 05 PM" src="https://github.com/user-attachments/assets/55e90cfc-03c6-498b-ab0e-1a14a51e1801">

Then copy/paste the displayed command onto the terminal ✅.

<img width="1320" alt="Screenshot 2024-10-05 at 9 06 47 PM" src="https://github.com/user-attachments/assets/e377f38c-b158-4426-94e2-022b6326d322">

_Now PM2 will automatically restart at boot 🎉🙌_


**Save the current state of the applications so they restore upon server restart:**


```
pm2 save
```

<img width="651" alt="Screenshot 2024-10-05 at 9 08 36 PM" src="https://github.com/user-attachments/assets/766b952f-5be1-4d41-8d0e-cd5783dd0189">



**Consider configuring monitoring tools to check the status and performance of the applications:**

For monitoring, I reviewed the documentation again and found [this](https://pm2.keymetrics.io/docs/usage/monitoring/)

PM2 gives you a simple way to monitor the resource usage of your application. You can monitor memory and CPU easily and straight from your terminal:

```
pm2 monit
```
<img width="1728" alt="Screenshot 2024-10-05 at 9 11 32 PM" src="https://github.com/user-attachments/assets/11a4f1a1-b8df-4ff4-ae49-782e4fe30245">

Check the logs:
```
pm2 logs
```


## Testing and Validation ✨👩🏽‍💻✅


**Verify that all applications are functioning correctly by accessing the specified ports from a web browser**
<img width="1131" alt="Screenshot 2024-10-05 at 9 14 58 PM" src="https://github.com/user-attachments/assets/dac272b9-5584-429e-99e1-c824ca9346bc">
<img width="1101" alt="Screenshot 2024-10-05 at 9 15 09 PM" src="https://github.com/user-attachments/assets/8048532a-b2f6-4e30-9afa-bb596ae49457">
<img width="1101" alt="Screenshot 2024-10-05 at 9 15 21 PM" src="https://github.com/user-attachments/assets/58ecdce8-ec8f-4dbc-8e0c-a6cd64fc8c12">



# Successfully deployed app ✨👩🏽‍💻✅

```
http://localhost:3000/
```
<img width="1256" alt="Screenshot 2024-10-05 at 8 48 28 PM" src="https://github.com/user-attachments/assets/27b2d8a8-0a27-4b04-82ac-2e46cabb2d7f">
<img width="1357" alt="Screenshot 2024-10-05 at 8 48 07 PM" src="https://github.com/user-attachments/assets/3e456e95-3016-4286-a288-dd5be8caed88">
<img width="1196" alt="Screenshot 2024-10-05 at 8 49 18 PM" src="https://github.com/user-attachments/assets/4bac3dbe-9b6e-46b4-8573-8d0cbe7494de">
<img width="1279" alt="Screenshot 2024-10-05 at 8 49 31 PM" src="https://github.com/user-attachments/assets/c7c71245-5d02-4c7d-9952-8710992ed0a9">

<img width="1061" alt="Screenshot 2024-10-05 at 8 49 57 PM" src="https://github.com/user-attachments/assets/a662d30b-fa54-41cf-bb63-59b0b4521006">
<img width="1053" alt="Screenshot 2024-10-05 at 8 50 30 PM" src="https://github.com/user-attachments/assets/161494c7-4f76-48eb-9645-a1e15306da45">
<img width="1061" alt="Screenshot 2024-10-05 at 8 50 42 PM" src="https://github.com/user-attachments/assets/1129adce-3d66-4af8-a2ea-578a65e10cfa">

