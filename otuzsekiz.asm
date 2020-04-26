bits 64 ; kendi komu satırımı yazıcam.

section .data
    gecicikom: db "command argv"
    komut: times 150 db 0
    komuta: dq 10
    argumanlar: times 150 db 0
    gosterge: db 10,">"
    gostergeu: equ $-gosterge
    sinir: db 0
    hatamesaji: db "syntax error"
    hatamesajil: equ $-hatamesaji
    komuthatasi: db "unknown command error"
    komuthatasil: equ $-komuthatasi

section .bss
    input: resb 100
    inputu: equ $-input

section .text
    global main
main:
    mov rbp, rsp; for correct debugging
    call gbas
    call iread
    call bk
    jmp kisle
    call cikiskomutu


bk: ; gecici komut icerik degerlendirilmesi
    mov rax, 0
    bk1:
    cmp byte [input+rax], ";"
    je bk2
    cmp rax, 145
    jg hataligiris
    mov rbx, [input+rax]
    mov [komut+rax], rbx
    inc rax
    jmp bk1
    bk2:
    mov [komuta], rax
    ret


kisle: ; komut işleme fonskiyonu
    cmp dword [komut], 1953069157
    je cikiskomutu
    cmp dword [komut], 452623234404
    je biseyyapma
    jmp commandunk


biseyyapma:
    nop
    jmp main

cikiskomutu:
    mov rax, "<" ; exit code to 60 to 0x3c
    syscall


iread: ; inputu okur
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, inputu
    syscall
    ret

pkomut:
    mov rax, 1
    mov rdi, 1
    mov rsi, komut
    mov rdx, [komuta]
    syscall
    ret

gbas: ; gostergeyi ekrana basar
    mov rax, 1
    mov rdi, 1
    mov rsi, gosterge
    mov rdx, gostergeu
    syscall
    ret

hataligiris:
    mov rax, 1
    mov rdi, 1
    mov rsi, hatamesaji
    mov rdx, hatamesajil
    syscall
    jmp main

commandunk:
    mov rax, 1
    mov rdi, 1
    mov rsi, komuthatasi
    mov rdx, komuthatasil
    syscall
    jmp main
