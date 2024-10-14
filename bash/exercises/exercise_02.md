# Exercise 2: Database Backup and Cleanup

## Case Description

You need to perform regular backups of a MySQL database and clean up old backups to save disk space.

## Exercise

### 2.1 Create a Bash script that performs a backup of a MySQL database, compresses it, and deletes backups older than 30 days.

## My Solution ✅

```
#!/bin/bash
date=$(date +%Y%m%d%H%M)
backup_dir="/path/to/backup"
mysqldump -u user -ppassword database | gzip > $backup_dir/backup_$date.sql.gz
find $backup_dir -type f -mtime +30 -name '*.gz' -exec rm {} \;
```
