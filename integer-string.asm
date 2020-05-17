bits 64
section .data
	sayi dq 1446 ; string olacak sayi
	liste times 15 db 0 ; null string
	index equ $-liste-1 ; index len(liste) - 1 yani mov [liste+index],1 yaparsak liste 00001 olur
section .text
	global main
main:
	mov r15,index ; rahat olması icin indexi r15 e atıyoruz
	mov ebx, 10 ; 10 a bolmek icin ebx e atıyoruz
	mov rax, [sayi] ; rax a sayiyi ayıyoruz
	dongum:
	cmp rax,10
	jl sonislem ; if (rax < 10) { sonislem(); }
	div ebx ; kalan dl icinde bolum rax in icinde ; dl = rax % ebx ; rax /= 10
	add dl,48 ; dl += 0x30
	mov [liste+r15], dl ; liste[index] = rax % ebx = dl
	xor rdx,rdx ; yeniden bolme yapması icin rdx i sıfırlıyoruz
	dec r15 ; indexi bir azaltıyoruz boylece bi soldaki basamaga geçecek
	jmp dongum ; bu islemler rax 10 dan kucuk olana kadar devam eder


	sonislem: ; rax 10 dan kucuk ise
	add rax,48 ; rax += 48 ; rax += "0"
	mov [liste+r15],al ; liste[index] = rax
	call printl ; listemizi yazıyoruz
	call exit ; programdan cikıyoruz
printl:
	mov rax,1
	mov rdi,1
	mov rsi,liste
	mov rdx,index
	inc rdx
	syscall
	ret
exit:
	mov rax,60
	xor rdi,rdi
	syscall

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                  in python                          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                 sayi = 1446                         ;
;          liste = list(str(sayi)                     ;
;                 print liste                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
