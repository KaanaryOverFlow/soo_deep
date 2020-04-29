section .data
    metin db "mesaj$"
    
    forsleep:
        bekle1 dq 0
        bekle2 dq 030000000

section .text
    global main

print:
    mov r14, [r15]
    cmp byte [r15], "$"
    je printdon
    mov rsi, r15
    call printc
    call uyku
    inc r15
    jmp print
    printdon:
    ret


printc:
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall
    ret



uyku:
    mov rax, 35
    mov rdi, forsleep
    syscall
    ret
