section .data
msg1 db 10,"Enter 5 numbers :",10
len1 equ $-msg1
msg2 db 10,"Five numbers are :",10
len2 equ $-msg2

section .bss
array resq 5
counter resb 1

%macro accept 0
mov rax,0
mov rdi,0
mov rsi,array
add rsi,rbx
mov rdx,64
syscall
add rbx,64
%endmacro

%macro display 0
mov rax,1
mov rdi,1
mov rsi,array
add rsi,rbx
mov rdx,64
syscall
add rbx,64
%endmacro

section .text
global _start
_start:

mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall
mov byte[counter],5
mov rbx,0
loop1:
accept
dec byte[counter]
jnz loop1
mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall
mov byte[counter],5
mov rbx,0
loop2:
display
dec byte[counter]
jnz loop2

mov rax,60
mov rdi,0
syscall
