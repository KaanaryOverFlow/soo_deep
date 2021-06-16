; echo -n "bir" | ./bir | hex | sed -e "s/6964656e7469666572/,0x/g" -e "s/^,/stri db /g"
bits 64
section .data
    errorm db "Bilinmeyen bir Hata olustu!",0x10
    errorml equ $-errorm
    stri times 600 db 0x00
    asdf dq 0
    blank db "identifer"
section .text
    global main
main:
    call oku
    call sifrele
    call yaz
    call exit
oku:
    mov rax,0
    mov rdi,0
    mov rsi,stri
    mov rdx,600
    syscall
    mov r14,rax
    mov r15,rax
    ret

sifrele:
    mov r13,stri
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
    ror al,2
    mov qword [asdf], 0
    jmp sifdevam
asdfs: ; asdf sifir ise
    rol al,2
    mov qword [asdf], 1
    jmp sifdevam


yaz:
    mov r12,stri
    yazdon:
    cmp r15,0
    jle yazbitti
    nop
    mov rax,1
    mov rdi,1
    mov rsi,blank
    mov rdx,9
    syscall
    nop
    mov rax,1
    mov rsi,r12
    mov rdx,1
    mov rdi,1
    syscall
    inc r12
    dec r15
    jmp yazdon
    yazbitti:
    ret


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

