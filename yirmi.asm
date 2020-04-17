BITS 64

section .data
    nokta: db "*"
    altsatiragec: db 10
    
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    
    mov bl, 0 ; satırdaki nokta sayısı
    mov bh, 21 ; toplam satır sayisi
    
    noktayaz:
    mov rax, 1
    mov rdi, 1
    mov rsi, nokta
    mov rdx, 1
    syscall
    inc bl
    cmp bh, bl
    jne noktayaz
    
    mov rax, 1
    mov rdi, 1
    mov rsi, altsatiragec
    mov rdx, 1
    syscall
    
    mov bl, 0
    dec bh
    cmp bh, 0
    jne noktayaz
    
    
    
    mov rax, 60
    syscall
