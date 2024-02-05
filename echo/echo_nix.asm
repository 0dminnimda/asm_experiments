format ELF64 executable 3

macro syscall3 sys_call_number, arg0, arg1, arg2
{
    mov rax, sys_call_number
    mov rdi, arg0
    mov rsi, arg1
    mov rdx, arg2
    syscall
}

macro syscall2 sys_call_number, arg0, arg1
{
    mov rax, sys_call_number
    mov rdi, arg0
    mov rsi, arg1
    syscall
}

macro syscall1 sys_call_number, arg0
{
    mov rax, sys_call_number
    mov rdi, arg0
    syscall
}

stdin = 0
stdout = 1
stderr = 2

sys_read = 0
sys_write = 1
sys_exit = 60

segment readable executable

entry main
main:
    lea rsi, [buff]
    syscall3 sys_read, stdin, rsi, buff_length

    lea rsi, [buff]
    syscall3 sys_write, stdout, rsi, buff_length

    syscall1 sys_exit, 0

segment readable writable

    buff rb 128
    buff_length = $-buff
