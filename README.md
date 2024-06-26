# Learn Assembly Language (x86)
following youtube tutorials by Davy Wybiral (thanks) and OliveStem (thanks)

## What is Assembly Langauge?
Assembly is a category of programming language (not a single language itself). This term applies to languages that provide almost no abstraction over the native instruction set (binary / machine code) of the processor. Assembly language is a *"human-readable"* form of machine code.

Comapared to other languages, Assembly gives you more direct control over the processor. This will require more code to perform relatively basic tasks. This is due to the fact that it lacks many of the abstractions that make higher-level languages so expressive and relatively easy to use.

Assembly langages are tied to the specific CPU architecture that they run on. ie, code written for an ARM processor (ex. Raspberry Pi or phone) will use different instruction set compared to code written for an Intel processor.

    In brief

    * Not really a language
    * Almost no abstraction
    * Basically machine code
    * More control
    * More code to write
    * Not very portable

## Understanding the CPU

Since assembly is so closely tied to the processor, it is important to understand the foundations of how a processor work.

Effectively, a processor is a machine that follows a sequence of instructions in order to perform a task. This tutorial follows the x86 architecture.

### Registers
These are like the scratchpad / working-memory for the processor. They hold values during the actual computation. Data is not meant to stay here for long. They are used to load data into a register, perform some computation and then save the result into a more permanent memory location.

The x86 architecture has several `general-purpose registers` that we can use to compute with, as well as several `special-purpose registers`.

The size of the registers is reflected by the CPU architecture. 32-bit machines have 32-bit registers and 64-bit machines have 64-bit registers. Backwards compatibility is maintained by allowing access to subsets of a register. 32-bit code can still run on 64-bit machines because the processor can treat half of the 64-bit register as though it was a 32-bit register.

    In brief
    * Working memory
    * Different purpose
    * Fixed width

### Stack
The Stack is a region of memory that behaves as a last-in-first-out (`LIFO`) data structure. This means that we can *push* values onto the stack to store them and then *pop* values off the stack to read them. It is similar to a stack of books. I like to see it as a test tube as compared to an pipe open at both ends.

The Stack is implemented as a contiguous array in memory. *Pushing* and *Poping* are accomplished by moving an index or a pointer. This pointer holds the location of the top of the stack. Thus, when we push a value, the pointer is moved and the value is written to the new pointer location. When we pop a value, it reads from the current pointer location and then moves the pointer location backwards.

We do have random access to all of this memory, so we are not limited to pushing and poping the stack.

The stack pointer is a value stored in a register that we can change if we need to alter the top of the stack.

    In brief
    * LIFO data structure
    * Is an array - Push / Pop
    * Stack pointer (register)
    * Random access possible

## Setting up the environment

To start, we need an 'assembler'. This is a program that is responsible to converting assembly code (human readable) into machine code (binary - machine readable).

Note: I am working on an Ubuntu VM and will use the 'NASM' assembler.

```cli
sudo apt install nasm
```

    Please note, my VM had the sources list pointing to the wrong repositories. It also lacked VS Code, Git and Binutils. Now I changed the source list to point to `http://old-releases.ubuntu.com`

`sources.list` is found at `/etc/apt` directory.

    Nasm is well supported but it is not the only assembler. Syntax can differ quite a bit between different assemblers, even for the same architecture.


To install git (as I will be using it for version control) use the following:

```cli
sudo apt install git
```

As I will be using VSCode, I will be isntalling this as well.
* Search for 'vscode install ubuntu'
* Find & Select Donwload Visual Studio Code in the results of the search engine.
* download the `.deb` file
* double click the downloaded file
* Click install and enter the user password when prompted
* VS Code is now installed.
* Build a project at your desired location.

## Project 1 and 2 - Fundamentals

See:
    * EX1-README.md
    * EX2-README.md

## Pojects 3 and 4 - Program Control flow

Assembly lacks the usual constructs like `iteration` `conditions` and `function calls`.
Instead, the programmer has to build this kind of behaviour using `jump` instructions.

### The Instruction Pointer
This is an internal pointer in the processor often labelled as `EIP`. As the program runs instruction after another,
this pointer holds the location for the machine code that the processor is executing.

This means that the processor can jump around to different locations in the code by altering this pointer.
Unlike a register, we cannot change the instruction pointer by using the normal `move`, `add` and `subtract` operations. Instead, the instruction pointer is changed by using the `jump` operation.

    In brief
    * EIP
    * Location of execution
    * Not like a register
    * Changed by jump ops

See:
    * EX3-README.md
    * EX4-README.md

## Project 5 - Memory Access and Stack Operations

We saw one example of addressing memory in the hello world program (ex2).


## Debugging

Using the `gdb` debugger. Debugging a file called `test`.

The following starts the debugging session

```
gdb test
```

start assembly layout
```
layout asm
```

create a breakpoint at `_start`

```
break _start
```

run the program in debug mode

```
run
```

step through instructions one by one

```
stepi
```
check what is stored in register

```
info registers ebx
```

Display what is stored at a particular pointer for register
```
x/x $esp
```

To display the string stored in a register

```
x/s $ecx
```

I get "Hey!\001"
`\001` is the ASCII control character SOH (Start of Header). It's a non-printable character, and its presence in the string could be due to a variety of reasons, depending on the context of your program.

```
x/x $ecx
x/x $ecx+1
x/x $ecx+2
x/x $ecx+3
```
To quit gdb
```
quit
```

### what does the x/x and x/s stand for?

In GDB (GNU Debugger), the x command is used to examine memory. The syntax of the command is `x/NFU ADDRESS`, where:

* `N` is an optional parameter that specifies the number of units to display.
* `F` is an optional parameter that specifies the format in which to display the units.
* `U` is an optional parameter that specifies the unit size.
* `ADDRESS` is the memory address to examine.  

The `F` parameter can take several values, including:

* `x` to display in hexadecimal.
* `s` to display as a null-terminated string.

So, `x/x $ecx` means "examine the memory at the address in the `ecx` register, displaying the result in **hexadecimal**", and `x/s $ecx` means "examine the memory at the address in the `ecx` register, displaying the result as a **null-terminated string**".
