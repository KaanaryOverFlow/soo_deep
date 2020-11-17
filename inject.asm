; otuz inject.asm
; sudo ./inject /dev/sdX
; Tamamen egitim amaclidir. hic bir sorumluluk kabul etmiyorum!
bits 32
section .data
	nonroot db "You Are no Root!",0x0a
	nonrootlen equ $-nonroot
	filenot db "Cant open argv1. you're sure that?",0x0a
	filenotlen equ $-filenot
	pname db "payload.bin",0
	payload times 512 db 0
	tf dd 0
	uzhata db "payload 512 byte degil",0x0a
	uzhatal equ $-uzhata
	basari db "injected successfull!",0x0a
	basaril equ $-basari
section .text
	global main
main:
	mov eax,24
	int 0x80
	cmp eax,0
	jne noroot
	call arg
	call inject
	mov eax,4
	mov ebx,1
	mov ecx,basari
	mov edx,basaril
	int 80h
	call exit

inject:
	mov eax,5
	mov ebx,pname
	mov ecx,0
	int 80h
	mov ebx,eax
	mov eax,3
	mov ecx,payload
	mov edx,512
	int 80h
	cmp eax,512
	jl uhata
	mov eax,4
	mov ebx,[tf]
	mov ecx,payload
	mov edx,512
	int 80h
	ret

uhata:
	mov eax,4
	mov ebx,2
	mov ecx,uzhata
	mov edx,uzhatal
	int 0x80
	jmp exit

arg:
	mov ebx,[esp+0xc]
	mov eax,5
	mov ecx,2
	int 0x80
	cmp eax,0
	jl nofile
	mov [tf],eax
	ret

nofile:
	mov eax,4
	mov ebx,1
	mov ecx,filenot
	mov edx,filenotlen
	int 0x80
	jmp exit

noroot:
	mov eax,4
	mov ebx,1
	mov ecx,nonroot
	mov edx,nonrootlen
	int 0x80
	jmp exit

exit:
	mov eax,1
	mov ebx,0
	int 0x80
