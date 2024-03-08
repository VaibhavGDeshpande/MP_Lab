global _start
%macro readwrite 3
mov rax,%1
mov rdi,%1
mov rsi,%2
mov rdx,%3
syscall
%endm
section .data
num1 dq 03h
num2 dq 02h
num3 dw 05h
num4 dw 04h
num5 db 06h
msg db "Enter 1: Addition 2:Subtraction 3: Multiplication 4:Division"
msg_len equ $-msg
msg1 db 0ah,"The ans is:- "
msg1_len equ $-msg1
msg2 db "Incorrect choice"
msg2_len equ $-msg2
msg3 db 0ah,"The quotient is:- "
msg3_len equ $-msg3
msg4 db 0ah,"The remainder is:- "
msg4_len equ $-msg4
count db 1Fh
remainder db 00
section .bss
ch1 resb 2
ascii_ans resb 0Fh
section .text
_start:
readwrite 1,msg,msg_len
readwrite 0,ch1,2
cmp byte[ch1],'1'
jne dn
call sum
jmp disp
dn: cmp byte[ch1],'2'
jne dn1
call minus
jmp disp
dn1: cmp byte[ch1],'3'
jne dn2
call multi
jmp disp
dn2: cmp byte[ch1],'4'
jne dn3
call divi
jmp div_display
dn3: readwrite 1,msg2,msg2_len
jmp ext
disp:readwrite 1,msg1,msg1_len
jmp d
div_display:readwrite 1,msg4,msg4_len
d:call disp1
ext: mov rax,60
syscall
sum: mov rax,[num1]
mov rbx,[num2]
add rax,rbx
mov rbx,rax
ret
minus:mov rax,[num1]
mov rbx,[num2]
sub rax,rbx
mov rbx,rax
ret
multi:
mov ax,[num3]
mov bx,[num4]
mul bx
mov bx,ax
mov eax,edx
rol eax,16
mov ax,bx
mov rbx,rax
ret
divi:
mov rbx,0
mov rcx,0
mov ax,[num4]
mov bl,[num5]
div bl
mov bl,al
mov [remainder],ah
readwrite 1,msg3,msg3_len
call disp1
mov rax,0
mov al,[remainder]
mov rbx,rax
ret
disp1: mov rsi,ascii_ans
mov rax,rbx
up: rol rax,4
mov rbx,rax
and al,0Fh
cmp al,09
jng dn4
add al,07h
dn4: add al,30h
mov [rsi],al
inc rsi
mov rax,rbx
dec byte[count]
jnz up
mov rax,1
mov rdi,1
mov rsi,ascii_ans
mov rdx,16
syscall
ret
