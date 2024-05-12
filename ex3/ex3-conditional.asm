global _start

section .text
_start:
    mov ecx, 101 ; set ecx to 99
    mov ebx, 42 ; exit status is 42
    mov eax, 1  ; sys_exit system call
    cmp ecx, 100; compare ecx with 100
    jl skip     ; jump 'if less than' to "skip" label
    mov ebx, 13 ; change exit status to 13
skip:           ; jump operation will move the instruction pointer to here
    int 0x80    ; interrupt to exit the program