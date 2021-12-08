BITS 64 ;;; metini sezar algoritmasına gore tek karakterlik kaydirma islemi yapıcak



section .data
    metin: db "ltb`ghs^R`q`s`q"
    metinlen: equ $-metin
    index: db 0

section .text
global main
main:
    mov rbp, rsp; for correct debugging debug başlangıç için gerekli


    mov cx, metinlen ; sayma işlemi için değer verdik

    tekrar:

    xor eax, eax
    mov ax, [index] ; koseli parantez eax e izin verdigi icin eax i çekiyoruz
    
    
    
    mov bh, [metin+eax] ; anlık karakteri bh a atıoruz
    
    inc bh ; bh değeri bir artırılır
    
    mov [metin+eax], bh
    
    
    
    
    
    xor eax, eax ; eax sıfırlanır
    mov eax, [index] ; eax veri tabanındaki güncel değeri alır
    inc eax ; eax bir artırılır
    mov [index], eax ; artırılan güncel eax veri tabanına yazılır
    
    
    dec cx
    cmp cx, 0
    jnz tekrar
    
    mov eax, 4
    mov ebx, 1
    mov ecx, metin
    mov edx, metinlen
    int 80h
    
    
    ; cikis koduları
    mov eax, 1
    int 80h