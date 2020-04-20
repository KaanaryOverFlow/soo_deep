bits 64 ;  0100011001100110010011110010000001101011010000110111010101000110
section .data
    text1: db "bir sayi gir ->"
    text1u: equ $-text1
    errort: db "Hatali giris",10
    erroru: equ $-errort
    bas2: db 48 ; onlar basamagi -> 0
    karsi: dd 0 ; birler basamagi
    calisiyo: db "burasi calisiyo", 10
    cu: equ $-calisiyo
    anlik: db 10

    
section .bss
    sayi1: resd 1
    sayi2: resd 1


section .text
    global main

main:
    mov rbp, rsp; for correct debugging
    mov rsi, text1
    mov rdx, text1u
    call print
    mov rsi, sayi1
    mov rdx, 3
    call read

    cmp byte [sayi1],"0"
    jl hata
    cmp byte [sayi1], "9"
    jg hata

    mov rsi, text1
    mov rdx, text1u 
    call print
    mov rsi, sayi2
    mov rdx, 3
    call read

    cmp byte [sayi2], "0"
    jl hata
    cmp byte [sayi2], "9"
    jg hata
    
    
    
    mov r15, [sayi1]
    mov r14, [sayi2]
    sub r15, 48
    sub r14, 48
    mov r13, r15
    add r13, r14
    add r13, 48
    
    
    mov [karsi], r13
    cmp byte [karsi], "9"
    jg onlukat

    
    bibitartik:
    mov [karsi], r13
    mov rsi, karsi
    mov rdx, 1
    call print
    call yenisatir
    call exit

onlukat:
    mov r9, [bas2]
    inc r9
    mov [bas2], r9
    mov rsi, bas2
    mov rdx,1
    call print
    sub r13, 10
    jmp bibitartik





dogrulukkontrol:
    mov r15, [sayi1]
    mov r14, [sayi2]
    sub r15, 48
    jz hata
    ret


read:
    mov rax, 0
    mov rdi, 0
    syscall
    ret


print:
    mov rax, 1
    mov rdi, 1
    syscall
    ret

hata:
    mov rsi, errort
    mov rdx, erroru
    call print
    call exit


yenisatir:
    mov rax,1
    mov rdi,1
    mov rdx,1
    mov rsi, anlik
    syscall
    ret
    

debug:
    mov rax, 1
    mov rdi, 1
    mov rsi, calisiyo
    mov rdx, cu
    syscall
    ret

exit:
    mov rax, 60
    syscall
