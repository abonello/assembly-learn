global _start

section .data
    msg db "Hello, world!", 0x0a ; 10 - code for new line charachter
    len equ $ - msg ; this automatically sets the length of the string
                    ; so that if the string is changed
                    ; we do not have to manually change this.

section .text ; switch back to code
_start:
    mov eax, 4      ; sys_write system call
    mov ebx, 1      ; stout file descriptor
    mov ecx, msg    ; bytes to write - string pointer
    mov edx, len    ; number of bytes to write - string length
    int 0x80        ; perform system call
    mov eax, 1      ; sys_exit system call
    mov ebx, 0      ; exit status is set to 0
    int 0x80        ; perform system call