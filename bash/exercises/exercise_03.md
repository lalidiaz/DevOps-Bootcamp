# Exercise 3: Temporary File Cleanup

## Case Description

Temporary files and old logs can fill up the disk over time. You need to automate the cleanup of these files.

## Exercise

### 3.1 Create a Bash script that cleans up temporary files and logs older than 10 days.

## My Solution ✅

```
#!/bin/bash
find /tmp -type f -atime +10 -delete
find /var/log -type f -name '*.log' -mtime +10 -delete
```
