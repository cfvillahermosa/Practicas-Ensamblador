; multi-segment executable file template.
data segment
msg db "Introduzca un numero de un digito $"
msg1 db " El numero al que corresponde en la serie fibonacci es: $"
v db 0,1,1,2,3,5,8,13,21,34
diez db 10
num db 2 dup ("& $")
pkey db " pulse una tecla para salir...$"
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

;AQUI EMPIEZA EL PROGRAMA
lea dx, msg
mov ah, 9
int 21h

mov ah, 01h
int 21h

sub al, 30h
xor cx, cx


lea di,v
xor bx,bx


bucle:

cmp bl ,al
jg fin
mov dl,[di]

inc di
inc bl
loop bucle
fin:
mov al,dl
mov ah, 0
div diez
add ax, 3030h
mov num,al
mov num[1],ah


lea dx, msg1
mov ah,09h
int 21h


lea dx, num
mov ah,09h
int 21h

;AQUI TERMINA


lea dx, pkey
mov ah, 9
int 21h ; output string at ds:dx

; wait for any key....
mov ah, 1
int 21h

mov ax, 4c00h ; exit to operating system.
int 21h
ends
end start ; set entry point and stop the assembler.