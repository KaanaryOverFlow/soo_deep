# assembly 64/32/16 bit programs
### assembly project files on one-file

[![GitHub issues](https://img.shields.io/github/issues/MucahitSaratar/soo_deep)](https://github.com/MucahitSaratar/soo_deep/issues) [![GitHub forks](https://img.shields.io/github/forks/MucahitSaratar/soo_deep)](https://github.com/MucahitSaratar/soo_deep/network) [![GitHub stars](https://img.shields.io/github/stars/MucahitSaratar/soo_deep)](https://github.com/MucahitSaratar/soo_deep/stargazers) [![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Ftwitter.com%2F0x00deadbeef)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2FMucahitSaratar%2Fsoo_deep)

#### alti and otuz is same file. just different is;
- alti is compiler for 64-bit
- otuz is compiler for 32-bit

## requirements
- nasm
- python

## usage compiler
- $ ```compiler program.asm <arguments>```
- compiler: ./alti or ./otuz
- program: file.asm eg. hex_generator.asm
- arguments: q,s,d,+,s+,d+ (not obliagory)
- - q -> only compile, doesn't run binary
- - s -> run as ```strace ./binary```
- - d -> run as ```gdb -q ./binary```
- - \+ -> run as ```sudo ./binary```
- - s+ -> run as ```sudo strace ./binary```
- - d+ -> run as ```sudo gdb -q ./binary```
