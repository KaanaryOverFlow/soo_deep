bits 64
section .data
    chars db "-\|/$"
    charsl equ $-chars
    chars2 db "-/|\$"
    chars2l equ $-chars2
    chars3 db "-   $"
    blank db " "
    acilis db "["
    kapanis db "]"
    normalcumle db " Hello friend. please follow me on github. Not: uzun sure bakinca metasploit f. oluyosun"
    normalcumlel equ $-normalcumle
    tumuzunluk equ normalcumlel+7
    imlec times tumuzunluk db 0x08

    bekleme:
        dq 0
        dq 100000000

section .text
    global main
main:
    mov r15,chars
    mov r14,chars2
    mov r13,chars3
    gogogo:
    call pac
    call pchar
    call pblank
    call pucchar
    call pblank
    call pikichar
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


pblank:
	mov rax,1
	mov rdi,1
	mov rsi,blank
	mov rdx,1
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

pucchar:
	mov rax,1
	mov rdi,1
	mov rsi,r13
	mov rdx,1
	syscall
	inc r13
	cmp byte [r13],"$"
	je ayarlauc
	ret

ayarlauc:
	mov r13,chars3
	ret

pikichar:
	mov rax,1
	mov rdi,1
	mov rsi,r14,
	mov rdx,1
	syscall
	inc r14
	cmp byte [r14],"$"
	je ayarlaiki
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

ayarlaiki:
	mov r14,chars2
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
