# Memory Access and Stack Operations

Start a new project and make initial declarations and create a `.data` section.

In the data section create a label called "addr". This is short for address.
We are using this name to highlight the fact that this label is just a pointer to some memory address. We are pointing at a memory location that contains the string "yellow".

```
global _start
section .data
    addr db "yellow"
```

`db` means 'defined byte'. It is used to declare initialized data in the data section of your program.  
The db directive tells the assembler to store the bytes of "yellow" in the memory location referred to by the label addr. Each character in the string "yellow" is stored as a single byte, and the string is null-terminated, meaning a null byte (\0) is appended at the end.

After this we will switch to a `.text` section to start our code and create a `_start` label.

```
section .text
_start:
```

Set eax to 4 so that we can do a 'system write' (`sys_write`) call. Then set ebx to 1 to write to standard out.
Set ecx to our addr label and set edx to 6 to set how many bytes we want to write.

Finally make the system call by using an interrupt.

After this we can change the system call in ebx to 1 and exit with a status call of 0 - which is the customary value to show 'no error'.

```
section .text
_start:
    mov eax, 4    ; sys_write system call
    mov ebx, 1    ; stdout file descriptor
    mov ecx, addr ; bytes to write
    mov edx, 6    ; number of bytes to write (yellow is 6 bytes long)
    int 0x80      ; make system call defined in ebx
    mov eax, 1    ; sys_exit system call
    mov ebx, 0    ; exit status is 0
    int 0x80      ; make system call defined in ebx
```

Assemble, Link etc . . . 

```
nasm -f elf32 ex5.asm -o ex5.o
ld -m elf_i386 ex5.o ex5
./ex5
echo $?
```

## Changing the data stored in memory

`ex5b.asm`

use `mov [addr], byte 'H'`

This is using a move operation where the first operand is our addr label. Notice the square brakcet syntax - `[addr]`.

This means that we are moving some data into that address.

The second operand is `byte 'H'`.
This means that the byte representation of the charachter H is what will be moved into the memory at our address.

The `byte` keyword is important because the move operation can also be used for larger integers than bytes. The assembler needs to know how much data is being moved. Since addr points to beginning of our string, that is where H will be moved to.

We can also use an offset to ccess other parts of the data, ex. `mov [addr+5], byte '!'`
This will move an exclamation point into the memory at our address plus an offest of 5. (in our case, the last charachter of yellow.)


Assemble, Link and execute...
We will get 

Hello!


Up to now we dealt with contiguous bytes in the data section. There are other data types.

### Examples of common data types

```
section .data
    ; db is 1 byte            8 bits
    name1 db "string"       ; byte strings
    name2 db 0xff           ; byte literals (Hex)
    name3 db 100            ; decimal literals
    ; dw is 2 bytes           16 bits
    name4 dw 0x1234
    name5 dw 1000
    ; dd is 4 bytes           32 bits
    name6 dd 0x12345678
    name7 dd 100000
```

We have been using `db` to store byte strings but we can also use it to store byte literals.

If we want to encode a larger integer. For this we can use a `dw` data type. There are larger data types but since this tutorial focuses on 32 bit architecture we will stop here.

## The Stack
LIFO data structure. The Stack is just an array with its pointer pointing at the top of the array. We also have random access to this memory, thus we can read and write at arbitrary locations within it.




