; multi-segment executable file template.

data segment
    ; add your data here!
    fila    db 0
    columna db 0
    x db 100 dup ('&')
    ALFANU db 10 dup ('&')
    BINV db 0
   
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    mov fila,2 ;posicionamos el cursor en la fila 2
    mov columna,5 ;posicionamos el cursor en la columna 5
    call CURSOR
    lea dx,x ;estas 2 instrucciones son para meter en la variable "x" los datos leidos
    call LEERDATOS
    

            

    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends



CURSOR proc near
       push ax
       push bx        
       push dx
       mov dh,fila
       mov dl,columna
       mov bh,0
       mov ah,2
       int 10h
       pop dx
       pop bx
       pop ax
       ret
CURSOR endp 



LEERDATOS proc near ;este procedimiento guarda el valor en la variable donde tngo direccionado dx
    push ax
    mov ah,10
    int 21h
    pop ax
    ret
LEERDATOS endp



BORRAR proc near
    
       push ax
       push bx
       push cx
       push dx
       mov al,0     ;pagina principal(1 pantalla)
       mov cx,0     ;borramos desde la posicion 0
       mov dx,2479h ; hasta la posicion 2479h(es dcir toda la pantalla)
       mov bh,7     ;con que color quiero que se quede el cursor(7=blanco,5=amarillo...)
       mov ah,6
       int 10h
       pop dx
       pop cx
       pop bx
       pop ax
       ret
BORRAR endp   


ASCDEC proc near  ; pasa una cadena numerica en ALFANU a un valor hexadecimal en BINV
       
       push ax
       push bx
       push cx
       push dx
       push si
       push di
       
       mov ax,0
       mov bx,0
       mov cx,0
       lea si,ALFANU
       
       
       ASCDEC1: cmp [si],'$'
                je ASCDEC2
                mov bl,[si]
                sub bl,'0'
                mul cx
                add ax,bx
                inc si
                jmp ASCDEC1
       
       ASCDEC2: mov BINV,al
                pop di
                pop si
                pop dx
                pop cx
                pop bx
                pop ax 
                
       ret
ASCDEC endp
       
    

end start ; set entry point and stop the assembler.
