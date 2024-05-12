# Looping

Building a loop using jump instructions.

We will build a loop that will compute 2 to the ecx power by looping ecx number of times. It will double another register with each iteration.

We will keep the result in ebx so that we can easily display it as status at the end of the program. We will start ebx at 1.

Then set ecx to 4. This is the number of iterations, thus we will compute 2 to the 4th power.

We will create a label that will be the start of the loop. We will call it `label`.

Inside the loop we will perform the following:

    * double ebx by adding it to itself
    * then we will reduce the value of ecx by 1
        Note:
        we will use `dec` operator.
        This decrement operator is more efficient than if we had to do a subtract.  
        There is also and `inc` operator which performs an increment.
    * Next we will compare ecx with 0
    * This is followed by a conditional jump. We will use the `jg` operator. If ecx is greater than 0 the instruction pointer is moved back to "label".
    Since ecx is decremented each time, it will eventually reach 0. At this point we will exit the loop.

After the loop we will set eax (the system call) to 1, thus making a sys_exit. Then perform the interrupt.

```
global _start

section .text
_start:
    mov ebx, 1   ; start ebx at 1
    mov ecx, 4   ; set number of iterations
label:
    add ebx, ebx ; double ebx, ebx += ebx
    dec ecx      ; decrement ecx, ecx -= 1
    cmp ecx, 0   ; compare ecx with 0
    jg label     ; conditional jump, jump if ecx > 0 
    mov eax, 1   ; sys_exit system call
    int 0x80
```
Next we will run the program and check the result which we are storing in the exit code.

Note: storing the result in the exit status is not the 
standard way to return a result. We should set status 
code to 0 if the program ends successfully and return 
any results in another way such as output to standard output.
We are using Status here for convenience.

Run the following commands in the appropriate folder.

```
nasm -f elf32 ex4.asm -o ex4.o
ld -m elf_i386 ex4.o -o ex4
./ex4
echo $?
```
We will get 16 since 2^4 is 16.

If we change the number stored in ecx to 6 we will get 64 since 2^6 is 64.