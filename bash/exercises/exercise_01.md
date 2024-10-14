# Exercise 1: Web Application Deployment

## Case Description
Your company has a web application based on the LAMP stack (Linux, Apache, MySQL, PHP). Whenever there is a new version of the code, you need to deploy it to the production server. This process includes:

1. Stopping the web server to avoid inconsistencies while deploying the new version.
2. Backing up the current files and the database.
3. Fetching the latest version of the code from the repository.
4. Installing dependencies.
5. Configuring permissions and environment variables.
6. Restarting the web server.

### Exercise

#### 1.1 Create a Bash script that automates the web application deployment process described above.

## My Solution ✅

```
#!/bin/bash

echo "Stopping the web server to avoid inconsistencies while deploying the new version..."
systemctl stop apache2

echo "Backing up the current files and the database..."
tar -czvf $APP_DIR/backup_$(date +%Y%m%d%H%M).tar.gz $APP_DIR
mysqldump -u user -ppassword database > $APP_DIR/backup_db_$(date +%Y%m%d%H%M).sql

echo "Fetching the latest version of the code from the repository..."
cd $APP_DIR
git pull origin main

echo "Installing dependencies..."
composer install

echo "Configuring permissions and environment variables..."
chown -R www-data:www-data $APP_DIR
chmod -R 755 $APP_DIR
cp $APP_DIR/.env.example $APP_DIR/.env
php artisan key:generate

echo "Restarting the web server..."
systemctl start apache2

echo "Deployment completed successfully."
```
