bits 64
section .data
    errorm db "Bilinmeyen bir Hata olustu!",0x10
    errorml equ $-errorm
    stri db 0x89,0x5a,0xc9
    strilen equ $-stri
    asdf dq 0
section .text
    global main
main:
    call sifrele
    call exit

sifrele:
    mov r13,stri
    mov r14,strilen
    sifdon:
    cmp r14,0
    jle sifrelemebitti
    nop
    mov al,byte [r13]
    nop
    cmp qword [asdf], 0
    je asdfs
    cmp qword [asdf], 1
    je asdfb
    jmp error
    sifdevam:
    mov byte [r13], al
    inc r13
    dec r14
    jmp sifdon

sifrelemebitti:
    ret

asdfb: ; asdf bir ise
    rol al,2
    mov qword [asdf], 0
    jmp sifdevam
asdfs: ; asdf sifir ise
    ror al,2
    mov qword [asdf], 1
    jmp sifdevam




error:
    mov rax,1
    mov rdi,2
    mov rsi,errorm
    mov rdx,errorml
    syscall

exit:
    mov rax,60
    xor rdi,rdi
    syscall

