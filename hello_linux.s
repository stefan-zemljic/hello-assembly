.section .data
msg:    .ascii "Hello, world!"
len = . - msg

.section .text
.global _start
_start:
    movl $4, %eax           # syscall: sys_write
    movl $1, %ebx           # file descriptor: stdout
    movl $msg, %ecx         # pointer to message
    movl $len, %edx         # length of message
    int $0x80               # make system call

    movl $1, %eax           # syscall: sys_exit
    movl $0, %ebx           # exit code
    int $0x80               # make system call
