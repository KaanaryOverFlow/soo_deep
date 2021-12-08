; yazılımsal repeater yapamaya çalıştım. binset içerisindeki 0x04 monitor moda aldığım ağ kartımı işaret ediyor.
bits 64
section .data
        non db "you're not root!",0x0a
        nonlen equ $-non
        fd dq 0
        paket times 150 dq 0
        paketlen dq $-paket
        bindset dw 17
                db 0x00,0x03
                dq 0x04,0x02
        bindsetlen equ $-bindset
section .text
        global main
main:
        call create_socket
        call bind
        fonk1:
        call read
        call write
        jmp fonk1
        ;call exit

create_socket:
        mov rax,41
        mov rdi,17
        mov rsi,3
        mov rdx,0x300
        syscall
        cmp rax,0
        jl hata1
        mov [fd],rax
        ret

write:
        mov rax,1
        mov rdi,[fd]
        mov rsi,paket
        mov rdx,[paketlen]
        syscall
        ret

read:
        mov rax,0
        mov rdi,[fd]
        mov rsi, paket
        mov rdx,15000
        syscall
        mov [paketlen],rax
        ret


bind:
        mov rax,49
        mov rdi,[fd]
        mov rsi,bindset
        mov rdx,bindsetlen
        syscall
        ret


hata1:
        mov rax,1
        mov rdi,2
        mov rsi,non
        mov rdx,nonlen
        syscall

exit:
        mov rax,60
        mov rdi,0
        syscall
