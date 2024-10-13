# Exercise 4: Real-Time Log Monitoring

## Case Description
You want to monitor system logs in real-time and receive a notification when the word "ERROR" is detected.

## Exercise
4.1 Create a Bash script that monitors system logs in real-time and sends an email notification when the word "ERROR" is detected.

## My Solution ✅

```
#!/bin/bash

# Email variables
EMAIL="laura@example.com"
SUBJECT="Error Detected in System Logs"
LOG_FILE="/var/log/syslog"

# Monitor logs and send email when an ERROR is detected
tail -f $LOG_FILE | grep --line-buffered "ERROR" | while read -r line; do
    echo "Error found: $line" | mail -s "$SUBJECT" $EMAIL
done
```
