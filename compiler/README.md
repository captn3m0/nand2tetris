# compiler README

## Specification

## Class Structure

```jack
class name {
  field and static variable declarations //must precede subroutine
  subroutine declarations  // constructor, method, and function

  // subroutines can be of three types:
  constructor|method|function name (param-list) {
    local variable declarations
    statements
  }

}
```

## Comments

```c
// comment to end of line
/* Comment until closing */
/** Documentation comment */
```

## Symbols

|Symbol|Usage|
|------|-----|
|`()`  |arithmetic expressions and parameter lists and argument lists
|`[]`  |array indexing
|`{}`  |grouping program units and statements
|`,`   |variable list separator
|`;`   |statement terminator
|`=`   |assignment and comparison operator
|`.`   |class membership
|`+-*/|&~<>` |operators

## Reserved Keywords

```
class, constructor, method, function
int, boolean, char, void
var, static, field
let, do, if, else, while, return
true, false, null
this
```

## Constants

- Integer constants can _only be positive_. negastive constants are expressions with the minus operator on a integer constant.
- String constants need "double quotes". Cannot contain newline or doublequote.
- Boolean constants are `true`, and `false`
- `null` signifies a null reference

## Identifiers

- `A-Z, a-z, 0-9, _`. First character can't be a digit.
- Language is case-sensitive

## Main

- There must be a `Main` class. THis class must have atleast one function named `main`.


## Variables

- Must be declared before usage.
- Data types can be primitive (int, char, boolean) or object type. String|Array types are provided by standard library.
- char is "unicode"!
- Creation of object type only creates a reference null pointer. Creating a new instance using the constructor creates the actual memory allocation.

### Types

1. Static
2. Field
3. Local
4. Parameter

## Arrays

- Array entries do not have a declared type, and different entries in the same array may have different types.

## Type conversions

- automatic for `char/int` dual-ways.
- integers can be used as memory addresses.
- classes mostly behave as C structures for memory allocation. So using a class object with array syntax will give you the correct result. (Need to check if assignment is by reference here or by value)


## Statements

- `let variable = expression;`
- `let variable[expression1] = expression2;`
- `if (expression) {s1} [else {s2}]`
- `while (expression) {statements}`
- `do function-or-method-call;`
- `return [expression];`

curly brackets are always mandatory

## Expression

See Figure 9.9

## Standard Library

|Class|Provides|
|-----|--------|
|Math|provides basic mathematical operations
|String|implements the String type and string-related operations|
|Array|implements the Array type and array-related operations|
|Output|handles text output to the screen|
|Screen|handles graphic output to the screen|
|Keyboard|handles user input from the keyboard|
|Memory|handles memory operations|
|Sys|provides some execution-related services.|

### `Math`

This class enables various mathematical operations. Everything is a function

- `void init ()`: for internal use only.
- `int abs (int x)`: returns the absolute value of x.
- `int multiply(int x, int y)`: returns the product of x and y.
- `int divide(int x, int y)`: returns the integer part of x/y.
- `int min(int x, int y)`: returns the minimum of x and y.
- `int max(int x, int y)`: returns the maximum of x and y.
- `int sqrt(int x)`: returns the integer part of the square root of x.

### `String`

This class implements the String data type and various string-related operations.  

#### Constructors

- `String new(int maxLength)`: constructs a new empty string (of length zero) that can contain at most maxLength characters;

#### Methods

- `void dispose()`: disposes this string;
- `int length()`: returns the length of this string;
- `char charAt(int j)`: returns the character at location j of this string;
- `void setCharAt(int j, char c)`: sets the j-th element of this string to c;
- `String appendChar(char c)`: appends c to this string and returns this string;
- `void eraseLastChar()`: erases the last character from this string;
- `int intValue()`: returns the integer value of this string (or of the string prefix until a non-digit character is detected);
- `void setInt(int j)`: sets this string to hold a representation of j;

### Functions
- `char backSpace()`: returns the backspace character;
- `char doubleQuote()`: returns the double quote (`"`) character;
- `char newLine()`: returns the newline character.  

### `Array`

This class enables the construction and disposal of arrays.

- `function Array new(int size)`: constructs a new array of the given size;
- `method void dispose()`: disposes this array.  

### `Output`

This class allows writing text on the screen. Everything is a function.

- `void init()`: for internal use only;
- `void moveCursor(int i, int j)`: moves the cursor to the j-th column of the i-th row, and erases the character displayed there;
- `void printChar(char c)`: prints c at the cursor location and advances the cursor one column forward;
- `void printString(String s)`: prints s starting at the cursor location and advances the cursor appropriately;
- `void printInt(int i)`: prints i starting at the cursor location and advances the cursor appropriately;
- `void println()`: advances the cursor to the beginning of the next line;
- `void backSpace()`: moves the cursor one column back.  

### `Screen`

This class allows drawing graphics on the screen. Column indices start at 0 and are left-to-right. Row indices start at 0 and are top-to-bottom. The screen size is hardware-dependant (in the Hack platform: 256 rows by 512 columns).  

- `void init()`: for internal use only;
- `void clearScreen()`: erases the entire screen;
- `void setColor(boolean b)`: sets a color (white = false, black = true) to be used for all further drawXXX commands;
- `void drawPixel(int x, int y)`: draws the (x,y) pixel;
- `void drawLine(int x1, int y1, int x2, int y2)`: draws a line from pixel (x1,y1) to pixel (x2,y2);
- `void drawRectangle(int x1, int y1, int x2, int y2)`: draws a filled rectangle whose top left corner is (x1,y1) and bottom right corner is (x2,y2);
- `void drawCircle(int x, int y, int r)`: draws a filled circle of radius r <= 181 around (x,y).  

### `Keyboard`

This class allows reading inputs from a standard keyboard. Everything is a function.

- `void init()`: for internal use only;
- `char keyPressed()`: returns the character of the currently pressed key on the keyboard; if no key is currently pressed, returns 0;
- `char readChar()`: waits until a key is pressed on the keyboard and released, then echoes the key to the screen and returns the character of the pressed key;
- `String readLine(String message)`: prints the message on the screen, reads the line (text until a newline character is detected) from the keyboard, echoes the line to the screen, and returns its value. This function also handles user backspaces;
- `int readInt(String message)`: prints the message on the screen, reads the line (text until a newline character is detected) from the keyboard, echoes the line to the screen, and returns its integer value (until the first nondigit character in the line is detected). This function also handles user backspaces.  

### Memory

This class allows direct access to the main memory of the host platform. Everything is a function.

- `void init()`: for internal use only;
- `int peek(int address)`: returns the value of the main memory at this address;
- `void poke(int address, int value)`: sets the contents of the main memory at this address to value;
- `Array alloc(int size)`: finds and allocates from the heap a memory block of the specified size and returns a reference to its base address;
- `void deAlloc(Array o)`: De-allocates the given object and frees its memory space.  

### `Sys`

This class supports some execution-related services. Everything is a function.

- `void init()`: calls the init functions of the other OS classes and then calls the Main.main () function. For internal use only;
- `void halt()`: halts the program execution;
- `void error(int errorCode)`: prints the error code on the screen and halts; ■ function void wait(int duration): waits approximately duration milliseconds and returns.

### Error Codes

1. `Sys.wait`: Duration must be positive
1. `Array.new`: Array size must be positive
1. `Math.divide`: Division by zero
1. `Math.sqrt`: Cannot compute square root of a negative number
1. `Memory.alloc`: Allocated memory size must be positive
1. `Memory.alloc`: Heap overflow
1. `Screen.drawPixel`: Illegal pixel coordinates
1. `Screen.drawLine`: Illegal line coordinates
1. `Screen.drawRectangle`: Illegal rectangle coordinates
1. `Screen.drawCircle`: Illegal center coordinates
1. `Screen.drawCircle`: Illegal radius
1. `String.new`: Maximum length must be non-negative
1. `String.charAt`: String index out of bounds
1. `String.setCharAt`: String index out of bounds
1. `String.appendChar`: String is full
1. `String.eraseLastChar`: String is empty
1. `String.setInt`: Insufficient string capacity
1. `Output.moveCursor`: Illegal cursor location
