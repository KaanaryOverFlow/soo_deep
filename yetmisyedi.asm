; Yazan Mücahit Saratar
; Yazım amacı: network'ü daha yakından anlamak
; 7 eylül 2020

bits 64
section .data
	socket dq 0
	sudoe db "socket olutururken hata cikti. sudo olarak calistir",0x0a
	sudoel equ $-sudoe
	iname dw "lo",0

	okumak times 0x05ea db "0"
	okumakl equ $-okumak
	;        <---------hedef mac----------><-----kaynak mac------------><protocol type: ipv4>
	deneme db 0x01,0x02,0x03,0x04,0x05,0x06,0x01,0x02,0x03,0x04,0x05,0x06,0x08,0x00 ; ethernet
	; version-ihl-servis tipi-toplam uzunluk/kimlik-bayraklar/ttl-protocol-header-checksum/kaynak ip-hedef ip
	db 0x45,0x00,0x00,0x28,0xab,0xcd,0x00,0x00,0x40,0x06,0xa6,0xec,0x0a,0x0a,0x0a,0x02,0x0a,0x0a,0x0a,0x01 ; ip herder
	; kaynak port-hedef-port/sıra numarası/onay numarası/gerisi çok karışık
	db 0x30,0x39,0x00,0x50,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x50,0x02,0x71,0x10,0xe6,0x32,0x00,0x00 ; tcp header
	denemel equ $-deneme

	forbind dw 0x11
		db 0x00,0x00
		dq 0x01,0x02 ; ,0x50 ; ,0x30
	forbindl equ $-forbind

section .text
	global main
main:
	call csoc
	call ioctl
	call bind
	call ssock
	call clsoc
	call exit


oku:
	mov rax,0
	mov rdi,[socket]
	mov rsi,okumak
	mov rdx,okumakl
	syscall
	ret


ssock:
	mov rax,1 ; sendto(44)
	mov rdi,[socket]
	mov rsi,deneme
	mov rdx,denemel
	;mov r10,0
	syscall
	ret


clsoc:
	mov rax,3
	mov rdi,[socket]
	syscall
	ret


ioctl:
	mov rax,16
	mov rdi,[socket]
	mov rsi,35123
	mov rdx,iname
	syscall
	ret



bind:
	mov rax,49
	mov rdi,[socket]
	mov rsi,forbind
	mov rdx,forbindl
	syscall
	ret



csoc:
	mov rax,41
	mov rdi,17
	mov rsi,3
	mov rdx,0 ; 8 ; -> 8 ip
	syscall
	cmp rax,0
	jl hata1
	mov [socket],rax
	ret

hata1:
	mov rax,1
	mov rdi,2
	mov rsi,sudoe
	mov rdx,sudoel
	syscall
	call exit

exit:
	mov rax,60
	mov rdi,0
	syscall
