bits 64
section .data
	char db "b","d","q","p","$"
	charl equ $-char
	ochar db " "
	bos db 0x08

	bekleme:
		saniye dq 0
		nanosaniye dq 100000000

section .text
	global main
main:
	mov r15,char
	call don
	call exit

don:
	cmp byte [r15],"$"
	jne devam
	sub r15,charl
	devam:
	call imlec_sola
	mov rsi,r15
	call pc
	call beklef
	inc r15
	jmp don


pc: ; print char
	mov rax,1
	mov rdi,1
	mov rdx,1
	syscall
	ret


beklef: ; bekleme fonksiyonu
	mov rax,35
	mov rdi,bekleme
	syscall
	ret


imlec_sola:
	mov rax,1
	mov rdi,1
	mov rsi,bos
	mov rdx,1
	syscall
	ret


exit:
	mov rax,"<"
	mov rdx,0
	syscall
