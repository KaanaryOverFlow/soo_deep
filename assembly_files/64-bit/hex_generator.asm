bits 64
section .data
  rbyte db 0
  keygen times 100 db 0
section .text
  global main
main:
  call create
  call printk
  call exit

printk: ; print keygen
  mov rax,1
  mov rdi,1
  mov rsi,keygen
  mov rdx,100
  syscall
  ret

create:
  mov r15,0x00
  mov r14,keygen
  createdon:
  call getrandombyte
  mov [r14],rax
  inc r14
  inc r15
  cmp r15,100
  jl createdon
  ret


getrandombyte:
  mov rax,318
  mov rdi,rbyte
  mov rsi,1
  xor rdx,rdx
  syscall
  xor rdx,rdx
  mov rbx,16
  mov rax,[rbyte]
  div rbx
  mov rax,rdx
  cmp rax,10
  jl getsayi
  add rax,87
  ret

getsayi:
  add rax,'0'
  ret

exit:
  mov rax,"<"
  xor rdi,rdi
  syscall
