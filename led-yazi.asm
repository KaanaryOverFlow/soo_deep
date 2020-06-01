bits 64
section .data
	yansin db 0x1b,"[03;5m "
	metin1 db "normal yazi",10,"$"
	metin2 db "yanip sonen ve italik yazi",10,"$"
section .text
	global main
main:
	mov r15,metin1
	call yaz
	call renk
	mov r15, metin2
	call yaz
	call exit




renk:
	mov rax,1
	mov rdi,1
	mov rsi,yansin
	mov rdx,8
	syscall
	ret



yaz:
	cmp byte [r15],"$"
	je yazbitir
	mov rsi,r15
	mov rax,1
	mov rdi,1
	mov rdx,1
	syscall
	inc r15
	jmp yaz
	yazbitir:
	ret


exit:
	mov rax,"<"
	mov rdi,0
	syscall
