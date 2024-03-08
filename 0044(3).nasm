global _start
section .data
msg1 db "Maximum number is: ",0ah
len1 equ $-msg1
arr db 1Fh,2Dh,3Eh
section .bss
count resb 1
maxx resb 4
section .text
_start:
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdi,len1
syscall
mov byte[count],05
mov rsi,arr
mov al,0
up:
cmp al,[rsi]
jnc dn
mov al,[rsi]
inc rsi
dec byte[count]
jnz up
dn:
inc rsi
dec byte[count]
jnz up
mov cx,02
mov rsi,maxx
upp: rol al,04
mov bl,al
and al,0Fh
cmp al,09
jng dnn
add al,07h
dnn: add al,30h
mov [rsi],al
mov al,bl
inc rsi
dec cx
jnz upp
mov rax,1
mov rdi,1
mov rsi,maxx
mov rdx,4
syscall
mov rax,60
syscall
