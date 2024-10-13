# Exercise 5: Task Automation with Cron

## Case Description
You need to schedule several automatic tasks, such as cleaning temporary files, backing up databases, and updating applications.

## Exercise
### 5.1 Create the necessary entries in the crontab to perform the following tasks:

- Clean temporary files daily at midnight.
- Backup the database every Sunday at 3 AM.
- Update a web application daily at 2 AM.

## My Solution ✅

```
#!/bin/bash

crontab -e

echo "Clean temporary files daily at midnight..."
0 0 * * * /path/to/cleaning_script.sh

echo "Backup the database every Sunday at 3 AM..."
0 3 * * 0 /path/to/backup_mysql.sh

echo # "Update a web application daily at 2 AM..."
0 2 * * * /path/to/update_script.sh
```
