# My first assemply program - EX1

The first two lines will define the entry point for our program. This is where the processor will start executing our instructions from.

**`global`** keyword - makes identifier accessible to the linker
```
global _start
```
An `identifier` followed by `:` makes a **label**.

A `label` is used to name locations in our code.

```
_start:
```
`mov` - moves integer of 1 into general purpose register called **eax**
```
    mov eax, 1
```
The we use **mov** again to move integer of 42 into general purpose register called **ebx**
```
    mov ebx, 42
```
`int` - interrupt - processor transfers control to an interrupt handler that is specified by the value given to int. In this case we have **0x80** which is an interrupt handler for **system calls**.  
The system call that it makes is determined by **EAX register**, 1 (in this case) - makes an **system exit call,** ie. signals end of program.  
The value stored in **EBX** will be the exit status for our program.
```
    int 0x80
```

## Building and running the program

In a terminal use the following command to assemble this program into machine code

```cli
 nasm -f elf32 ex1.asm -o ex1.o
 ```
elf32 passed as the f flag - tells nasm to build a 32bit elf object file.

**elf** means `executable and linking format`. It is the executable format used by linux.


Next we will use the following command
```cli
 ld -m elf_i386 ex1.o -o ex1
 ```
 The linker ld is used to build an executable from the object file we created in the previous step.

 m flag - to specify that it is an x86 elf program.

The result is stored in a file called **ex1** - our final executable program.
 

To run it use the following command
```cli
 ./ex1
 ```
 
 To inspect the exit status code use
 ```cli
 echo $?
 ```
 
 We get 42. In this case this means that the program ran successfully and was able to set the exit status.


 ## Subtracting a number

 Add the following line after setting ebx

 ```
    sub ebx, 29
```

This line subtracts 29 from the 42 already in the register (ebx). The subtraction is done in place. So it alters the value stored in ebx. The exit status should now be 13.


```
    nasm -f elf32 ex1.asm -o ex1.o
    ld -m elf_i386 ex1.o -o ex1
    ./ex1
    echo $?
```

 We get 13.

 ## Operations

 **`operator [operands, ...]`**

 This is the general syntax of operations in assembly. The operation / operand is a 3 or 4 letter mnemonic on the left. This is followed by some operands separated by comma.

 perform | code | note
 -----|------|---
Move / assign | mov
Addition  | add | in place
Subtract | sub  | in place
Multiply | mul  | always applied to eax register
Divide | div   | always applied to eax register
Interrupt | int

```
    mov ebx, 123 ; ebx = 123
    mov eax, ebx ; eax = ebx
    add ebx, ecx ; ebx += ecx
    sub ebx, edx ; ebx -= edx
    mul ebx      ; eax *= ebx
    div edx      ; eax /= edx
```

In assembly comments start with `;`