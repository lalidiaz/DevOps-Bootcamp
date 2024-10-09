# Process Management Exercises

## Exercise 1: Basic Commands for Process Management
### 1.1 Use ps to list all processes in the system.

```
ps -e
```

### 1.2 Use top to monitor processes in real-time. Which process is using the most CPU?

```
top
```

At the top of the top interface, you can see the process that is using the most CPU in real-time. It is listed in the %CPU column.

### 1.3 Use htop to monitor processes in real-time. What differences do you notice compared to top?

```
htop
```

htop provides a more user-friendly and visual interface, with colors that make it easier to read. Additionally, it allows navigation through processes using the arrow keys and offers more intuitive keyboard shortcuts.

## Exercise 2: Sending Signals to Processes
### 2.1 Use kill to terminate a specific process.

```
kill [PID]
```

### 2.2 Use pkill to terminate all processes matching a specific name.

```
pkill [process_name]
```

## Exercise 3: Process Priority
### 3.1 Start a process with a specific priority using nice.

```
nice -n 10 sleep 100
```

### 3.2 Change the priority of a running process using renice.

```
renice -n 5 -p [PID]
```

## Exercise 4: Running Processes in the Background

### 4.1 Run a command in the background using &.

```
sleep 100 &
```

### 4.2 Use bg to resume a background process and fg to bring it to the foreground.

```
# First, stop the foreground process (Ctrl + Z)
bg %1
fg %1
```

### 4.3 Use jobs to list all background jobs.

```
jobs
```
