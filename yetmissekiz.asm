bits 64
section .data
	index dq 1
	netarafa dq 0 ; 0 ise saga gitsin 1 ise sola
	space db " ",0
	text db "<-> ",0
	textl equ $-text
	temizleyici times 160 db 0x41
	temizleyicil equ $-temizleyici
	satirsilici times 180 db 0x08
	satirsilicil equ $-satirsilici

	forsl:
		saniye dq 0
		nanosaniye dq 040000000

section .text
	global main
main:
	call mak
;	call exit
	jmp main
	call exit

mak:
	call satirsil
	call satiryaz
	call islem
	ret

satirsil:
;	mov rax,1
;	mov rdi,1
;	mov rsi,temizleyici
;	mov rdx,temizleyicil
;	syscall
	mov rax,1
	mov rdi,1
	mov rsi,satirsilici
	mov rdx,satirsilicil
	syscall
	ret

islem:
	cmp qword [netarafa],0
	je indexarti
	cmp qword [netarafa],1
	je indexeksi



satiryaz:
	call pti
	call pchar
	ret


pchar:
	mov rax,1
	mov rdi,1
	mov rsi,text
	mov rdx,textl
	syscall
	call sleep
	ret


indexarti:
	inc qword [index]
	cmp qword [index],164
	jge soladon
	ret

soladon:
	mov qword [netarafa],1
	call pb
	call satirsil
	ret

indexeksi:
	dec qword [index]
	cmp qword [index],0
	jle sagadon
	ret

sagadon:
	mov qword [netarafa],0
	call pb
	call satirsil
	ret

pti: ; print to index
	mov rcx,[index]
	ptidon:
		push rcx
		call pb
		pop rcx
		cmp rcx,0
		jle ptidonn
		loop ptidon
	ptidonn:
	ret

pb: ; print bosluk
	mov rax,1
	mov rdi,1
	mov rsi,space
	mov rdx,1
	syscall
	ret



sleep:
	mov rax,35
	mov rdi,forsl
	mov rsi,0
	mov rdx,0
	syscall
	ret

exit:
	mov rax,60
	mov rdi,0
	syscall
