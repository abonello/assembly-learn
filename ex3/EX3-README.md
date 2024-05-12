# Conditional Flow

We can use various jump operators to control the program flow.

First we define the entry point

```
global _start

section .text
-start:
```

Then move 42 into ebx and 1 into eax

```
    mov ebx, 42
    mov eax, 1
    int 0x80
```

This sets the exit status to 42 and the system call to sys_exit. If we run the program at this point we will get a status of 42 at the end of the program.

Now we will implement a jump operation using the `jmp` opeerand. Insert this after the mov eax

```
    mov ebx, 42
    mov eax, 1
    jmp skip
    int 0x80
```

We are instructing the cpu to move the instruction pointer to the label called *skip*.

After the skip label we are going to do some action that will be skipped over by the jump operation. It will not be executed and  will prove that the jump actually happened. If this code had to be executed, the exit status code will change to 13.

```
    mov ebx, 13
```
This line of code is inserted immediately after the jump operation.

Next we will define the skip label. This is a way of naming a specific location in the code.

```
skip:
    int 0x80
```

After running the program and cheching the status code, we get 42. This means that the line of code setting the exit code to 13 was in fact skipped over.

```
nasm -f elf32 ex3.asm -o ex3.o
ld -m elf_i386 ex3.o -o ex3
./ex3
echo $?
```

This is an `unconditional jump`.

## Conditional jump

If we want to jump depending on a condition, then we will use `conditional jump`.
With this we can implement `conditional branching` by jumping forward over code. Or we can implement `looping` by jumping backwards.

We will use a *less than* comparison.

We will use ecx register to perform the test on.

```
mov ecx, 99 ; set ecx to 99
```

Then add a compare instruction to compare ecx with some arbitrary value

```
cmp ecx, 100
```

When the compare operation happens it does not jump and it might seem as it does not have any effect. It sets flags in the background. The comparison happens with the type of jump that we will do next.

For this we will change the `jmp` operand to `jl`. This means jump if less than, and will operate on the operands flagged in the comparison operation. 

```
jl skip
```

In this case we are testing if ecx is less than 100. Since we set ecx to be 99, thus it is less than 100 and the jump will happen.

```
global _start

section .text
_start:
    mov ecx, 99 ; set ecx to 99
    mov ebx, 42 ; exit status is 42
    mov eax, 1  ; sys_exit system call
    cmp ecx, 100; compare ecx with 100
    jl skip     ; jump 'if less than' to "skip" label
    mov ebx, 13 ; change exit status to 13
skip:           ; jump operation will move the instruction pointer to here
    int 0x80    ; interrupt to exit the program
```

If we run the program and check the status, we will get 42 confirming that the jump was executed.
```
nasm -f elf32 ex3-conditional.asm -o ex3.o
ld -m elf_i386 ex3.o -o ex3
./ex3
echo $?
```

If we change the value stored in ecx to 101 and run the program again, we will find that the status code is now 13. The jump did not happen as ecx is NOT less than 100.

### Common conditional jumps

operator    |  operand  |   notes 
----|----|----
je | A, B | jump if A is EQUAL to B
jne| A, B | jump if A is NOT EQUAL to B
jg | A, B | jump if A is GREATER than B
jge| A, B | jump if A is GREATER OR EQAUL to B
jl | A, B | jump if A is LESS than B
jle| A, B | jump if A is LESS OR EQUAL to B

There are some others to deal with special cases.

ja (Jump if Above): Jump if A is above B (unsigned comparison).  
jae (Jump if Above or Equal): Jump if A is above or equal to B (unsigned comparison).  
jb (Jump if Below): Jump if A is below B (unsigned comparison).  
jbe (Jump if Below or Equal): Jump if A is below or equal to B (unsigned comparison).  
jo (Jump if Overflow): Jump if the overflow flag is set.  
jno (Jump if No Overflow): Jump if the overflow flag is not set.  
js (Jump if Sign): Jump if the sign flag is set (result was negative).  
jns (Jump if No Sign): Jump if the sign flag is not set (result was positive).  
jz (Jump if Zero): Jump if the zero flag is set (result was zero). This is equivalent to je.  
jnz (Jump if Not Zero): Jump if the zero flag is not set (result was not zero). This is equivalent to jne.  
jc (Jump if Carry): Jump if the carry flag is set.  
jnc (Jump if No Carry): Jump if the carry flag is not set.  
jp (Jump if Parity): Jump if the parity flag is set (parity even).  
jnp (Jump if No Parity): Jump if the parity flag is not set (parity odd).  

These instructions allow for more nuanced control flow based on the results of previous operations.  








