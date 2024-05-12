global _start

_start:
    sub esp, 4 ; reserve space for the return value
               ; efectively allocated 4 bytes on the stack
    mov [esp], byte 'H' ; move the byte 'H' to the reserved space
    mov [esp+1], byte 'e' ; using offset move the byte 'e' to the reserved space
    mov [esp+2], byte 'y' ; using offset move the byte 'y' to the reserved 
    mov [esp+3], byte '!' ; using offset move the byte '!' to the reserved space
    mov eax, 4 ; syscall number for sys_write
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, esp ; pointer to bytes to write
    mov edx, 4 ; number of bytes to write
    int 0x80 ; call the kernel - perform system call
    mov eax, 1 ; syscall number for sys_exit
    mov ebx, 0 ; exit status code
    int 0x80 ; call the kernel - perform system call