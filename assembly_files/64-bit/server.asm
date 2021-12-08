bits 64
section .data
	sock dq 1 ; socket fd
	ac dq 1 ; client fd
	acik db "istemci baglanti gerceklestirdi. komut bekleniyor",10 ; baglanti sonrası ekrana yazilacak mesaj
	acikk equ $-acik
	data dw 2 ; struc * ; 2 -> af inet
		db 0x11,0x5c ; -> 4444
		db 127,0,0,1 ; 127.0.0.1
		times 8 db 0 ; 8 * zero
	datal equ $-data
	gelen times 50 dq 0 ; istemcinin mesajı
	gelenu equ $-gelen
section .text
	global main ; entry main
main:
	mov rax,41 ; create socket
	mov rdi,2 ; af inet
	mov rsi,1 ; sock stream
	mov rdx,0 ; ip proto
	syscall
	mov [sock],rax ; save socket fd
	mov rax,49 ; bind
	mov rdi,[sock] ; socket fd
	mov rsi,data
	mov rdx,datal
	syscall
	mov rax,50 ; listen
	mov rdi,[sock]
	mov rsi,5 ; listen nubmer
	syscall
	mov rax,43 ; accept
	mov rdi,[sock]
	xor rsi,rsi
	xor rdx,rdx
	syscall
	mov [ac],rax ; save client fd
	call sac ; print to karsilama mesaji
	dongu:
	mov rax,0 ; read
	mov rdi,[ac] ; client
	mov rsi,gelen
	mov rdx,gelenu
	syscall
	mov rax,1
	mov rdi,1
	mov rsi,gelen
	mov rdx,gelenu
	syscall
	cmp byte [gelen], "Q"
	jne dongu ; kısaca client Q\n gonderene kadar clientden data okuyup sunucu ekranına basar
	call socketkapat
	call exit

socketkapat:
	mov rax,3
	mov rdi,[sock]
	syscall
	ret

sac: ; server is acik
	mov rax,1
	mov rdi, 1
	mov rsi,acik
	mov rdx,acikk
	syscall
	ret

exit:
	mov rax,"<"
	xor rdi,rdi
	syscall
