nasm -f elf64 -o sezar.o sezar.asm

ld -o sezar sezar.o
