bits 64
section .data ; data segment
	sock1 dq 1
	text1 db "socket create error!",10,0
	text1l equ $-text1
	text2 db "Port acik",10,0
	text2l equ $-text2
	yaz db 0
	dest dw 2
		port db 0x00,0x01
		ip db 192,168,1,1
		bosluk times 8 db 0
	destl equ $-dest
section .text
	global main
main:
	call scan
	call exit_code

scan:
	call create_socket
	call connect
	call close
	inc byte [port+1]
	cmp byte [port+1],0x00
	je solarti
	jmp scan

solarti:
	inc byte [port]
	cmp byte [port],0x00
	je bitebilirsin
	jmp scan

bitebilirsin:
	ret

port_open:
	mov rax,1
	mov rdi,1
	mov rsi,text2
	mov rdx,text2l
	syscall
	ret

connect:
	mov rax,42
	mov rdi,[sock1]
	mov rsi,dest
	mov rdx,destl
	syscall
	cmp rax,0
	je port_open
	ret


create_socket:
	mov rax,41
	mov rdi,2
	mov rsi,1
	mov rdx,0
	syscall
	cmp rax,0
	jl s_c_e
	mov [sock1],rax
	ret


close:
	mov rax,3
	mov rdi,[sock1]
	syscall
	ret



s_c_e: ;socket create error
	mov rax,1
	mov rdi,2
	mov rsi,text1
	mov rdx,text1l
	syscall
	call exit_code
exit_code:
	mov rax,"<"
	mov rdi,0
	syscall
