bits 64 ; network dropper
section .data
    e1 db "Won't create a raw socket. permission error",0x0a,0x00
    s1 db "Created raw socket successfully",0x0a,0x00
    sockfd dq 0
    bindset: 
    dw 17
    dw 0x0300
    dd 0x02
    dq 0x02
    dq 0x00
    bindsetlen equ $-bindset
    packet times 150 dq 0
    packetlen dq $-packet
section .text
    global main
main:
    call csoc
    call bind
    call rfs
    call exit

rfs: ; read from socket
    mov rax,0
    mov rdi,[sockfd]
    mov rsi,packet
    mov rdx,packetlen
    syscall
    ret

bind:
    mov rax,49
    mov rdi,[sockfd]
    mov rsi,bindset
    mov rdx,bindsetlen
    syscall
    ret

csoc:
    mov rax,41
    mov rdi,17
    mov rsi,3
    mov rdx,0x300
    syscall
    cmp rax,0
    jg csucs
    mov rdi,2
    mov rsi,e1
    call puz
    call exit
    csucs:
    mov [sockfd],rax
    mov rsi,s1
    mov rdi,1
    call puz
    ret

puz: ; print until zero. before call set to rdi.
    mov rdx,1
    puzzloop:
    cmp byte [rsi],0x00
    je puzret
    mov rax,1
    syscall
    inc rsi
    jmp puzzloop
    puzret:
    ret

exit:
    mov rax,"<"
    xor rdi,rdi
    syscall