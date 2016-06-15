; multi-segment executable file template.
data segment
sqrt db 0,0
i db 1
cad db 3 dup (' $')
diez db 10
msg db "introduzca un numero para averiguarle la parte entera de su raiz $"
msg1 db " la parte entera de su raiz es...: $"

ends
stack segment
dw 128 dup(0)
ends
code segment
start:
; set segment registers:
mov ax, data
mov ds, ax
mov es, ax
xor ax, ax
lea dx, msg
mov ah, 9
int 21h

mov dl, 0

bucle:
xor ax,ax
cmp dl, 2
je bucle1
mov ah,1
int 21h
sub ax, 3030h
mov sqrt[di],al
inc dl
inc di
loop bucle


bucle1:
xor bx,bx
xor ax,ax
mov di,0
mov al,sqrt[di]
mul diez
mov sqrt[di],al
cmp bl, 2
je formar_numero
inc bl

formar_numero:
mov al,sqrt[0]
add al,sqrt[1]
mov bl,1


bucle2:

sub al, bl
cmp al, 0
je fin_bucle
jl fin_bucle1
inc i
add bl,2

jmp bucle2
fin_bucle:

mov al, i
div diez
add ax, 3030h
mov cad, al
mov cad[1],ah
jmp fin

fin_bucle1:

mov al, i
sub al, 1
div diez
add ax, 3030h
mov cad, al
mov cad[1], ah
jmp fin

fin:

lea dx,msg1
mov ah,9
int 21h

lea dx, cad
mov ah, 09h
int 21h


mov ah, 1
int 21h

mov ax, 4c00h ; exit to operating system.
int 21h
ends
end start ; set entry point and stop the assembler.