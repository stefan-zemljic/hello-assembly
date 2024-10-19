    .section .data
hello:
    .asciz "Hello, Windows!"         # Message to print

    .section .text
    .globl _start                    # Entry point for the program

    .extern GetStdHandle
    .extern SetConsoleMode
    .extern WriteConsoleA
    .extern ExitProcess

_start:
    # Align the stack to 16 bytes
    subq $8, %rsp                    # Align stack to 16 bytes (Windows x64 ABI requires this)

    # Get the handle for standard output
    movq $-11, %rcx                  # STD_OUTPUT_HANDLE = -11
    call GetStdHandle                # Call GetStdHandle
    movq %rax, %rcx                  # Move returned handle to %rcx for WriteConsoleA

    # Set up the parameters for WriteConsoleA
    lea hello(%rip), %rdx            # lpBuffer (address of the message)
    movq $15, %r8                    # nNumberOfBytesToWrite (length of the message)
    xorq %r9, %r9                    # lpOverlapped (NULL)
    call WriteConsoleA               # Call the Windows API function

    # Restore the stack
    addq $8, %rsp                    # Restore stack to original state

    # Exit the process
    xorq %rcx, %rcx                  # Exit code = 0
    subq $8, %rsp                    # Align the stack again to 16 bytes before calling ExitProcess
    call ExitProcess                 # Call ExitProcess to exit the program
