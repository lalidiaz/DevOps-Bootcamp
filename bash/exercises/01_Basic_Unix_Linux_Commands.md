# Exercises for Basic Unix/Linux Commands

## Exercise 1: Navigating the File System

### 1.1 List the contents of the current directory.

```
ls
```

### 1.2 List all files, including hidden ones, in your home directory.

```
ls -a ~
```

### 1.3 Change to the /var/log directory and then return to your home directory.

```
cd /var/log
cd ~
```

### ### 1.4 Print the full path of the current directory.

```
pwd
```

### 1.5 Create a directory named test in your home directory and then create a subdirectory subtest inside test.

```
mkdir ~/test
mkdir ~/test/subtest

```

### 1.6 Delete the subprueba directory.

```
rmdir ~/prueba/subprueba

```

## Exercise 2: File and Directory Management

### 2.1 Create an empty file named file1.txt in the current directory.

```
touch file1.txt
```

### 2.2 Copy file1.txt to a new file named file2.txt.

```
cp file1.txt file2.txt
```

### 2.3 Move file2.txt to the test directory.

```
mv file2.txt ~/test/

```

### 2.4 Rename file1.txt to file_renombrado.txt.

```
mv file1.txt file_renombrado.txt

```

### 2.5 Delete the file file_renombrado.txt.

```
rm file_renombrado.txt

```

### 2.6 Recursively copy the test directory to a new directory named backup_test.

```
cp -r ~/test ~/backup_test
```

### 2.7 Delete the backup_test directory and all its contents.

```
rm -r ~/backup_test
```

## Exercise 3: Viewing and Editing Files

### 3.1 Display the contents of the file file1.txt (make sure you are in the directory where file1.txt is located).

```
cat file1.txt
```

### 3.2 Open file1.txt with less and navigate through the file.

```
less file1.txt
```

### 3.3 Use head to show the first 5 lines of file1.txt.

```
head -n 5 file1.txt
```

### 3.4 Use tail to show the last 5 lines of file1.txt.

```
tail -n 5 file1.txt
```

### 3.5 Open file1.txt with the nano text editor, write something, and save the file.

```
nano file1.txt
```

### 3.6 Open file1.txt with the vim text editor, write something, and save the file.

```
vim file1.txt
```

## Exercise 4: Final Challenge

### 4.1 Create a complex directory structure and organize files:

In your home directory, create the following directory structure:

```
css
Copy code
proyectos/
├── devops/
│   └── scripts/
└── web/
    ├── html/
    └── css/
```

```
mkdir -p ~/proyectos/devops/scripts ~/proyectos/web/html ~/proyectos/web/css
```

### 4.2 Create a file in each of the directories and write "Hello, DevOps" in each file.

```
echo "Hola, DevOps" > ~/proyectos/devops/scripts/mensaje.txt
echo "Hola, DevOps" > ~/proyectos/web/html/mensaje.txt
echo "Hola, DevOps" > ~/proyectos/web/css/mensaje.txt
```

### 4.3 Copy all files to a new directory backup_projects.

```
cp -r ~/proyectos ~/backup_projects
```

### 4.4 Verify that the files were copied correctly by displaying their contents.

```
cat ~/backup_proyectos/devops/scripts/mensaje.txt
cat ~/backup_proyectos/web/html/mensaje.txt
cat ~/backup_proyectos/web/css/mensaje.txt
```
