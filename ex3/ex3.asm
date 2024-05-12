global _start

section .text
_start:
    mov ebx, 42 ; exit status is 42
    mov eax, 1  ; sys_exit system call
    jmp skip    ; jump to "skip" label
    mov ebx, 13 ; change exit status to 13
skip:           ; jump operation will move the instruction pointer to here
    int 0x80    ; interrupt to exit the program