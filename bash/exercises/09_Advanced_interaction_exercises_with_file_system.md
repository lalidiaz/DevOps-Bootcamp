# Advanced Interaction Exercises with the File System

## Exercise 1: Hard and Symbolic Links

### 1.1 Create a hard link called hard_link.txt to a file called file.txt.

```
ln file.txt hard_link.txt
```

### 1.2 Create a symbolic link called symbolic_link.txt to a file called file.txt.

```
ln -s file.txt symbolic_link.txt
```

## Exercise 2: Virtual File Systems

### 2.1 Show information about the CPU from /proc.

```
cat /proc/cpuinfo
```

### 2.2 List all available network interfaces in /sys/class/net.

```
ls /sys/class/net
```

## Exercise 3: File Synchronization

### 3.1 Synchronize the project directory from your home directory to /backup.

```
rsync -av ~/project backup
```

### 3.2 Synchronize the project directory to a remote server using rsync with compression.

```
srync -avz ~/project laura@server:/route/remote
```

## Exercise 4: Compression and Archiving

### 4.1 Create a tar file called files.tar that contains two files: file1.txt and file2.txt.

```
tar -cvf files.tar file1.txt file2.txt
```

### 4.2 Extract the contents of the files.tar file.

```
tar xvf files.tar
```

### 4.3 Create a compressed tar file with gzip called files.tar.gz that contains a directory called directory

```
tar -czvf files.tar.gz directory
```

### 4.4 Extract the contents of the files.tar.gz file.

```
tar -xzvf files.tar.gz
```

### 4.5 Compress a file called file.txt using gzip.

```
gzip tile.txt
```

### 4.6 Decompress the file file.txt.gz using gunzip.

```
gunzip file.txt.gz
```

### 4.7 Create a zip file called files.zip that contains two files: file1.txt and file2.txt.

```
zip files.zip file1.txt file2.txt
```

### 4.8 Extract the contents of the files.zip file.

```
unzip files.zip
```

## Exercise 5: Advanced File and Directory Management

### 5.1 Find all .log files in your home directory and delete them.

```
find ~/ -name "*.log" -type f -delete
```

### 5.2 Find all .txt files modified in the last 7 days in your home directory

```
find ~/ -name "*.txt" -type f -mtime -7
```

### 5.3 Find all directories in your file system that occupy more than 1 GB.

```
du -h --max-depth=1 / | grep '[0-9]G'
```

### 5.4 List the processes that have the file /var/log/syslog open.

```
lsof /var/log/syslog
```

### 5.5 Monitor the directory /home/laura/project for real-time events.

```
inotifywait -m /home/laura/project
```

### 5.6 Check the disk space usage in your home directory.

```
du -sh ~/
```

### 5.7 Check the disk space usage in the file system.

```
df -h
```

### 5.8 Show detailed information of the file file.txt using stat.

```
stat file.txt
```
