bits 64
section .data
section .text
  global main
main:
  call exit
exit:
  mov rax,"<"
  xor rdi,rdi
  syscall
