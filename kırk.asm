bits 64 ;

section .data
    timespec:
        bubir  dq 0
        buiki dq 030000000 ; 10000000 -> 1 saniye
    
    metin: db "Ekrana her karakteri belirli bir bekleme suresinden sonra yazilacak metin",10,"$"
    metin2: db "Test: QWERTYUOPASDFGHJKLZXCVBNM.d",10,"$"

section .text
    global main

main:
    mov r15, metin
    call uzunyaz
    mov r15, metin2
    call uzunyaz
    call cikis

pc: ; print char
    push rax
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall
    pop rax
    ret


uzunyaz:
    cmp byte [r15], "$"
    je uzunyazdon
    mov rsi, r15
    call pc
    call uyku
    inc r15
    jmp uzunyaz
    uzunyazdon:
    ret


uyku:
    mov rax, 35
    mov rdi, timespec
    syscall
    ret



cikis:
    mov rax, 60
    syscall
