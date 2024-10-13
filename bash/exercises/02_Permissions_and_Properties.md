# Exercises on Permissions and Properties

### Exercise 1: Owners and Groups

#### 1.1 Changing Owner

Change the owner of a file named file1.txt to a different user.

```
chown user2 file1.txt
```

#### 1.2 Changing Group

Change the group of a file named file1.txt to a different group.

```
chgrp devops_group file1.txt
```

### Exercise 2: File and Directory Permissions

#### 2.1 Viewing Permissions

List the files in a directory with detailed permissions.

```
ls -l
```

#### 2.2 Modifying Permissions (Symbolic)

Change the permissions of a file named script.sh so that the owner has read and write permissions, the group has read permissions, and others have no permissions.

```
chmod u+rw,g+r,o-rwx script.sh
```

#### 2.3 Modifying Permissions (Numeric)

Change the permissions of a file named data.txt to 755.

```
chmod 755 data.txt
```

### Exercise 3: Special Permissions

#### 3.1 Applying Setuid

Apply the Setuid permission to an executable file named program.

```
chmod u+s programa
```

#### 3.2 Applying Setgid

Apply the Setgid permission to a directory named shared.

```
chmod g+s shared
```

#### 3.3 Applying Sticky Bit

Apply the Sticky Bit to a directory named tmp.

```
chmod +t tmp
```

### Exercise 4: File Creation Mask

#### 4.1 Viewing umask

Display the current umask setting.

```
umask
```

#### 4.2 Modifying umask

Change the file creation mask to 027.

```
umask 027
```
