# Bash Functions Exercises

## Exercise 1: Function Definition

### 1.1 Write a function that prints "Hello, World!" and call it from a script.

```
say_hi() {
  echo "Hello, World!"
}

say_hi
```

### 1.2 Write a function that accepts a name as a parameter and prints "Hi, [name]". Call it with different names.

```
greeting() {
  echo "Hi, $1"
}

greeting "Laura"
greeting "Molly"
```

## Exercise 2: Function Parameters

### 2.1 Write a function that accepts two numbers as parameters and returns their sum.

```
sum() {
  echo $(( $1 + $2 ))
}

sum 3 4
```

### 2.2 Write a function that accepts two numbers as parameters, stores their sum in a global variable, and prints the result.

```
sum() {
  result=$(( $1 + $2 ))
  echo $result
}

sum 3 4
```

## Exercise 3: Returning Values

### 3.1 Write a function that accepts two numbers as parameters and returns the larger of the two.

```
larger() {
  if [ $1 -gt $2 ]; then
    echo $1
  else
    echo $2
  fi
}

larger 10 20
```

### 3.2 Write a function that calculates the square of a number and returns the result.

```
square() {
  echo $(( $1 * $1 ))
}

result=$(square 5)
echo "The square of 5 is $result"
```

## Exercise 4: Variable Scope

### 4.1 Write a function that defines a local variable and a global variable. Call the function and demonstrate the difference in scope.

```
example() {
  local var_local="I am local"
  var_global="I am global"
}

example
echo $var_global  # Prints "I am global"
echo $var_local   # Prints nothing, as var_local is local to the function
```

## Exercise 5: Recursive Functions

### 5.1 Write a recursive function to calculate the factorial of a number.

```
factorial() {
  if [ $1 -le 1 ]; then
    echo 1
  else
    echo $(( $1 * $(factorial $(( $1 - 1 )) ) ))
  fi
}

result=$(factorial 5)
echo "The factorial of 5 is $result"
```
