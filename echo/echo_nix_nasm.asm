section .text
global _start

%define stdin 0
%define stdout 1
%define stderr 2

%define sys_read 0
%define sys_write 1
%define sys_exit 60

section .bss:
    buff resb 128
        .length: equ $ - buff

section .text
_start:
    mov  edx, buff.length
    lea  ecx, [buff]
    mov  ebx, stdin
    mov  eax, sys_read
    syscall

    mov  edx, buff.length
    lea  ecx, [buff]
    mov  ebx, stdout
    mov  eax, sys_write
    syscall

    mov  ebx, 0
    mov  eax, sys_exit
    syscall
