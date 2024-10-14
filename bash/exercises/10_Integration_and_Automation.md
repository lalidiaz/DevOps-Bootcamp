# Integration and Automation Exercises

## Exercise 1: Create an automatic backup script

### 1.1 Create a Bash script that performs a backup of a specific folder and saves it with a timestamp.

```
#!/bin/bash
day=$(date +%Y%m%d%H%M)
tar -czvf backup_$day.tar.gz /route/to/folder
```

## Exercise 2: Schedule tasks with Cron

### 2.1 Schedule a script to run every day at midnight and clean temporary files.

```
crontab -e
0 0 * * * /route/to/my_cleaning_script.sh
```

## Exercise 3: API Interaction

### 3.1 Create a script that retrieves data from an API and saves it to a file.

```
#!/bin/bash
curl -s "https://example.api.com/data" > data.json
```

## Exercise 4: Sending email notifications

### 4.1 Create a script that sends an email with a specific message.

```
#!/bin/bash
echo "This is an specific message!" | mail -s "Subject of the email" john@doe.com
```

## Exercise 5: Deploy a web application

### 5.1 Create a script that updates the code of a web application and restarts the web server.

```
#!/bin/bash
cd /var/www/my_web_app
git pull origin main
systemctl restart nginx
```
