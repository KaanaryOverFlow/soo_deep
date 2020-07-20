bits 64
section .data
    chars db "-\|/$"
    charsl equ $-chars
    acilis db "["
    kapanis db "]"
    normalcumle db " Hello friend. please follow me on github"
    normalcumlel equ $-normalcumle
    tumuzunluk equ normalcumlel+3
    imlec times tumuzunluk db 0x08

    bekleme:
        dq 0
        dq 100000000

section .text
    global main
main:
    mov r15,chars
    gogogo:
    call pac
    call pchar
    call pkap
    call pdevam
    call bekle
    call psil
    jmp gogogo

bekle:
    mov rax,35
    mov rdi,bekleme
    mov rsi,0
    syscall
    ret

pdevam: ; print devam
    mov rax,1
    mov rdi,1
    mov rsi,normalcumle
    mov rdx,normalcumlel
    syscall
    ret


psil: ; print sil
    mov rax,1
    mov rdi,1
    mov rsi,imlec
    mov rdx,tumuzunluk
    syscall
    ret


pchar: ; print char
    mov rax,1
    mov rdi,1
    mov rsi,r15
    mov rdx,1
    syscall
    inc r15
    cmp byte [r15],"$"
    je charayarla
    ret

charayarla:
    mov r15,chars
    ret


pkap: ; print kapanis
    mov rax,1
    mov rdi,1
    mov rsi,kapanis
    mov rdx,1
    syscall
    ret

pac: ; print ac
    mov rax,1
    mov rdi,1
    mov rsi,acilis
    mov rdx,1
    syscall
    ret
