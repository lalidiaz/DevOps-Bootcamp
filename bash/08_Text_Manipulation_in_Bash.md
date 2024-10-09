# Exercises on Text Manipulation in Bash

## Exercise 1: Using echo and cat
### 1.1 Print "Hello, World" to the terminal.

```
echo "Hello, World"
```

### 1.2 Create a file named greeting.txt and write "Hello, Bash" in it.

```
echo "Hello, Bash" > greeting.txt
```

### 1.3 Display the contents of greeting.txt using cat.

```
cat greeting.txt
```

## Exercise 2: Using head and tail
### 2.1 Show the first 10 lines of greeting.txt.

```
head greeting.txt
```

### 2.2 Show the last 5 lines of greeting.txt.

```
tail -n 5 greeting.txt
```

## Exercise 3: Using grep
### 3.1 Search for the word "Hello" in greeting.txt.

```
grep "Hola" greeting.txt
```

### 3.2 Perform a case-insensitive search for the word "hello" in greeting.txt.

```
grep -i "hello" greeting.txt
```

## Exercise 4: Using cut
### 4.1 Create a file data.csv with the following content:

```
Copy code
name,age,city
Juan,25,Madrid
Ana,30,Barcelona
```

```
echo -e "nombre,edad,ciudad\nJuan,25,Madrid\nAna,30,Barcelona" > data.csv
```

### 4.2 Use cut to display only the ages from data.csv.

```
cut -d "," -f 2 data.csv
```

## Exercise 5: Using sort and uniq

### 5.1 Create a file names.txt with some repeated names.

```
echo -e "Juan\nAna\nPedro\nAna\nMaria\nJuan" > names.txt
```

### 5.2 Sort the names in names.txt.

```
sort names.txt
```

### 5.3 Remove the duplicate names from names.txt.

```
sort names.txt | uniq
```

## Exercise 6: Using tr
### 6.1 Replace all the letters "a" with "o" in greeting.txt.

```
cat greeting.txt | tr 'a' 'o'
```

## Exercise 7: Using awk
### 7.1 Display the first column of data.csv.

```
awk -F"," '{print $1}' data.csv
```

### 7.2 Use awk to calculate the average age of the people in data.csv.

```
awk -F"," '{sum += $2; count++} END {print sum/count}' data.csv
```

## Exercise 8: Using sed

### 8.1 Replace "Hello" with "Goodbye" in greeting.txt.

```
sed 's/Hola/Adiós/' greeting.txt
```

### 8.2 Globally replace "Hello" with "Goodbye" in greeting.txt and save the changes to the file.

```
sed -i 's/Hello/Goodbye/g' greeting.txt
```
