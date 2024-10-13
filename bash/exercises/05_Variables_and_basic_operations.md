# Basic Variables and Operations Exercises

## Exercise 1: Variables in Bash
### 1.1 Define a variable called course and assign it the value "DevOps".

```
course="DevOps"
```

### 1.2 Display the value of the course variable in the terminal.

```
echo $course

```

### 1.3 Export the course variable and verify that it is available in a subshell.

```
export curso
```

```
bash -c 'echo $curso'
```

### 1.4 Remove the course variable.

```
unset curso
```

## Exercise 2: Arithmetic Operations

### 2.1 Perform the addition of 8 and 5, and store the result in a variable called sum_result.

```
sum_result=$((8 + 5))

```

### 2.2 Perform the subtraction of 15 minus 3, and store the result in a variable called subtraction_result.

```
subtraction_result=$((15 - 3))
```

### 2.3 Perform the multiplication of 7 by 6, and store the result in a variable called multiplication_result.

```
multiplication_result=$((7 * 6))
```

### 2.4 Perform the division of 20 by 4, and store the result in a variable called division_result.

```
division_result=$((20 / 4))
```

### 2.5 Calculate the modulus of 13 by 5, and store the result in a variable called modulus_result.

```
modulus_result=$((13 % 5))
```

## Exercise 3: String Operations
### 3.1 Define two variables called name and lastname, assign them your first name and last name. Then, concatenate them into a variable called full_name.

```
name="Rafa"
lastname="Delgado"
full_name="$name $lastname"
```

### 3.2 Display the length of the full_name variable.

```
longitud=${#fullname}
echo $longitud
```

### 3.3 Obtain a substring of full_name that contains the first 4 characters.

```
substring=${full_name:0:4}
echo $substring
```
