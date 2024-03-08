%macro display 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endm
%macro input 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endm
section .data
msg db 10,"Enter a string :",10
len equ $-msg
section .bss
ascii resb 4
ch1 resb 10
global _start
section .text
_start:
display msg,len
input ch1,10
dec rax
call show
mov rax,60
mov rdi,0
syscall
show:
rol ax,4
mov bx,ax
and ax,000fh
add ax,30h
mov rsi,ascii
mov [rsi],al
mov rcx,9
l1:
mov ax,bx
rol ax,4
mov bx,ax
and ax,000fh
add al,30h
inc rsi
mov [rsi],al
loop l1
display ascii,4
ret
