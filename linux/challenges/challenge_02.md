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
