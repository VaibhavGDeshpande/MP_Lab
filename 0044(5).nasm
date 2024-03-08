global _start
section .data
msg1 db "Count of positive numbers: ",0ah
len1 equ $-msg1
msg2 db 0ah,"Count of negative numbers: ",0ah
len2 equ $-msg2
array dw 8505h,90FFh,8700h,8800h,8A9Fh,0A0Dh,0200h
p_count db 0
n_count db 0
arrlen equ 7
section .bss
dispbuff resb 2
%macro readwrite 3
mov rax,%1
mov rdi,%1
mov rsi,%2
mov rdx,%3
syscall
%endm
section .text
_start:
mov esi,array
mov ecx,arrlen
up:
bt word[esi],31
jnc dn
inc byte[n_count]
jmp dnn
dn: inc byte[p_count]
dnn: inc esi
inc esi
loop up
readwrite 1,msg1,len1
mov bl,[p_count]
call display
readwrite 1,msg2,len2
mov bl,[n_count]
call display
exit:
mov rax,60
syscall
display:
mov edi,dispbuff
mov ecx,2
upp: rol bl,04
mov dl,bl
and dl,0Fh
cmp dl,09
jng dnnn
add dl,07h
dnnn: add dl,30h
mov [edi],dl
inc edi
loop upp
readwrite 1,dispbuff,2
ret

