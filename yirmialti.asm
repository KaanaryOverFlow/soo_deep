bits 64

section .data
    aha: db "ltb`ghsR`q`s`q"
    ahal: equ $-aha
    chr: db "e"

section .text
    global _start

_start:
    mov r8, aha
    mov r9, ahal
    don:
    mov r10, [r8]
    inc r10
    mov [chr], r10
    call print
    dec r9
    inc r8
    cmp r9, 0
    jnz don

    
    call exit
    
    
    
print:
    mov rax, 1
    mov rdi, 1
    mov rsi, chr
    mov rdx,1
    syscall
    ret
    
    
exit:
    mov rax, 60
    xor rdi, rdi
    syscall
