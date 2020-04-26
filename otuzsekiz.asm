bits 64 ; my console | usege >command;

section .data
    komut: times 150 db 0
    komuta: dq 10
    argumanlar: times 150 db 0
    gosterge: db 10,">"
    gostergeu: equ $-gosterge
    sinir: db 0
    hatamesaji: db "unknown command"
    hatamesajil: equ $-hatamesaji

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
    call kisle
    jmp main
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
    ret

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
