BITS 64 ; 64 bit yazıcam

section .data
    yildiz: db "*"
    altsatiragec: db 10
    bekleme:
        bir: dd 1
        iki: dd 0
    ilk: db 20

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    mov bh, 1 ; toplam satır sayisi olacak sayi
    ;;;;;;;;;;;;;;;;;;;; settings bölümü ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    anadongu:
    mov bl, 0 ; satırdaki toplam yıldız sayisi 
    tekrar:
        call yyaz
        inc bl
        cmp bh, bl
        jne tekrar
    inc bh
    call ayaz
    cmp [ilk], bh
    jne anadongu
    mov rax, 60
    xor rdi, rdi
    syscall


bekle:
    mov rax, 35
    mov rdi, bekleme
    mov rcx, 0
    syscall
    ret
    
yyaz: ; yıldız yazar
    mov rax, 1
    mov rdi, 1
    mov rsi, yildiz
    mov rdx, 1
    syscall
    ret
    
ayaz: ; alt satıra geçer
    mov rax, 1
    mov rdi, 1
    mov rsi, altsatiragec
    mov rdx, 1
    syscall
    ret
