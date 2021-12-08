bits 64
section .data
	silchr times 15 db 0x08
	index dq 14
	lenght equ 15
	sayi times lenght db "0"
	newline db 0x00
	bekle:
		saniye dq 0
		nanosaniye dq 050000000
section .text
	global main
main:
	call _remove_int_
	call _print
	call sleep
	call _incerement
	jmp main
	call exit

_remove_int_:
	mov rax,1
	mov rdi,1
	mov rsi,silchr
	mov rdx,15
	syscall
	ret

sleep:
	mov rax,35
	mov rdi,bekle
	syscall
	ret




_get_rax_index:
	mov rax,[index]
	ret	

_set_rax_index:
	mov [index],rax
	ret

_incerement:
	mov rax,[index] ; rax = 14
	mov rbx,sayi ; rbx = *sayi
	add rbx,rax ; rbx += rax // rbx += 14
	_incerement_loop
	mov ch,byte [rbx]
	cmp ch,0x39
	jl _incerement_kucuk
	mov byte [rbx],0x30
	dec rbx
	cmp byte [sayi],0x39
	jge exit
	jmp _incerement_loop
	ret

_incerement_kucuk:
	inc byte [rbx]
	sub rbx,rax


_newline:
	mov rax,1
	mov rdi,1
	mov rsi,newline
	mov rdx,1
	syscall
	ret


_print:
	mov rax,1
	mov rdi,1
	mov rsi,sayi
	mov rdx,lenght
	syscall
	;call _newline
	ret


exit:
	mov rax, 60
	xor rdi,rdi
	syscall
