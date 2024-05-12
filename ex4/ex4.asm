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
