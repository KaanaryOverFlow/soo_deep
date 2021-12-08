bits 64
section .data
        text1 db "hellomworld abcdefghijklmnoprstvyz mucahit saratar",0
        lent1 equ $-text1
        text2 db "gol",0
        lent2 equ $-text2-1
        barti db "bulundu",0x0a
        bartil equ $-barti
        beksi db "bulunamadi",0x0a
        beksil equ $-beksi
        index dq 0
section .text
        global main
main:
        call func
        call exit

func:
        mov r14,text2
        funcdongu:
        mov r15,text1
        add r15,[index]
        mov al, [r15]
        mov bl, [r14]
        cmp al,bl
        je karsilastir
        inc qword [index]
        cmp qword [index],lent1
        je yok
        jmp funcdongu
        ret

karsilastir:
        mov rsi,[r15]
        mov rdi,[r14]
        lea rsi,[r15]
        lea rdi,[r14]
        mov rcx,lent2
        rep cmpsb
        jne karsilastir_donus
        je var
        ret

karsilastir_donus:
        inc qword [index]
        jmp funcdongu

yok:
        mov rax,1
        mov rdi,1
        mov rsi,beksi
        mov rdx,beksil
        syscall
        ret

var:
        mov rax,1
        mov rdi,1
        mov rsi,barti
        mov rdx,bartil
        syscall
        ret

exit:
        mov rax,"<"
        mov rdi,0
        syscall
