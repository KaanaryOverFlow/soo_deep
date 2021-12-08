bits 64
section .data
	site db "icanhazip.com",0
	sitel equ $-site
	ip_adresi times 16 db 0 ; temsili
	dosya1 db "dns1.txt",0
	dosya2 db "dns2.txt",0
	debugm db "Bura calisiyor",10
	debugml equ $-debugm
	mesaj1 db "isek atiliyor, bekleyiniz luften....",10
	mesaj1l equ $-mesaj1
	mesaj2 db "Ulasmak istediginiz hostun ip adresi: ",0
	mesaj2l equ $-mesaj2

	sh db "/bin/sh",0
	shc db "-c",0
	echong db "echo 1 > dns1.txt",0
	echo dq sh,shc,echong,0

	sendsave db "echo $(cat dns1.txt) | bash > dns2.txt",0
	send_save dq sh,shc,sendsave,0

	comping db "ping -c 1 ",0
	compingl equ $-comping

	okunandata times 150 db 0
	okunandatal equ $-okunandata

	hata1 db "Bilinmeyen hata cikiliyor...."
	hata1l equ $-hata1


	fd1 dq 0
	fd2 dq 0

	bekleme:
		saniye dd 4
		nanosaniye dd 000000000

section .text
	global main
main:
	call karsila
	mov rax,57
	syscall
	cmp rax,0
	jz re_done_file
	call sleep_4
	call write_file
	mov rax,57
	syscall
	cmp rax,0
	jz run_file
	call sleep_10
	call read_file
	call ayikla
	call son_mesaj
	call yaz_ip
	call exit


son_mesaj:
	mov rax,1
	mov rdi,1
	mov rsi,mesaj2
	mov rdx,mesaj2l
	syscall
	ret


yaz_ip:
	mov rax,1
	mov rdi,1
	mov rsi,ip_adresi
	mov rdx,16
	syscall
	ret


ayikla:
	mov r15,okunandata
	mov rcx,okunandatal
	ayiklama_dongu:
	cmp byte [r15], "("
	je ayiklama_baslasin
	inc r15
	dec rcx
	cmp rcx,0
	jz error_1
	jmp ayiklama_dongu
	ayiklama_bitsin:
	mov byte [ip_adresi+eax],0
	inc eax
	mov byte [ip_adresi+eax],0
	ret



ayiklama_baslasin:
	xor eax,eax
	inc r15
	ayiklama_devamke:
	mov r14, [r15]
	mov [ip_adresi+eax], r14
	inc eax
	inc r15
	cmp byte [r15], ")"
	jz ayiklama_bitsin
	jmp ayiklama_devamke


error_1:
	mov rax,1
	mov rdi,1
	mov rsi,hata1
	mov rdx,hata1l
	syscall
	call exit



read_file:
	mov rax,2
	mov rdi,dosya2
	mov rsi,0
	syscall
	mov [fd2],rax
	mov rax,0
	mov rdi,[fd2]
	mov rsi,okunandata
	mov rdx,okunandatal
	syscall
	ret



karsila:
	mov rax,1
	mov rdi,1
	mov rsi,mesaj1
	mov rdx,mesaj1l
	syscall
	ret


run_file:
	mov rax,59
	mov rdi,sh
	mov rsi,send_save
	xor rdx,rdx
	syscall


sleep_10:
	mov dword [saniye], 10
	call sleep_4
	ret



write_file:
	mov rax,2
	mov rdi,dosya1
	mov rsi,1
	syscall
	mov [fd1],rax
	mov rax,1
	mov rdi,[fd1]
	mov rsi, comping
	mov rdx,compingl
	syscall
	mov rax,1
	mov rdi,[fd1]
	mov rsi,site
	mov rdx,sitel
	syscall
	mov rax,3
	mov rdi,[fd1]
	syscall
	ret


sleep_4:
	mov rax,35
	mov rdi,bekleme
	xor rsi,rsi
	xor rdx,rdx
	syscall
	ret



re_done_file:
	mov rax,59
	mov rdi,sh
	mov rsi,echo
	xor rdx,rdx
	syscall


exit:
	mov rax,"<"
	mov rdi,0
	syscall

debug:
	mov rax,1
	mov rdi,1
	mov rsi,debugm
	mov rdx,debugml
	syscall
	ret
; bu program gercekten muzazzam bi alıstırma oldu. yer yer baya zorlandım ama sonunda. iste burda
