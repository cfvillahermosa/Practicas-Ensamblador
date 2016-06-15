; multi-segment executable file template.

data segment
    ; add your data here!
    
    ALFANU  db 10 dup('$')

    msj1    db 'introduce 2 numeros $'
    fila    db 0
    columna db 0
    msj2    db 'el resultado es: '
    BINV    db 0
            db '$' 
             
    salida  db 10 dup('$')
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
            
    mov fila,5
    mov columna,3
    call cursor
    
    
    
    lea dx,msj1
    mov ah,9
    int 21h
    
    lea dx,ALFANU
    mov ah,10
    int 21h  
    
    call ASCDEC 
    
    
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends 



cursor proc near
       push ax
       push bx        
       push dx
       mov  dh,fila
       mov  dl,columna
       mov  bh,0
       mov  ah,2
       int  10h
       pop  dx
       pop  bx
       pop  ax
       ret
cursor endp 



leerdatos proc near ;este procedimiento guarda el valor en la variable donde tngo direccionado dx
    push ax
    mov  ah,10
    int  21h
    pop  ax
    ret
leerdatos endp



borrar proc near
    
       push ax
       push bx
       push cx
       push dx
       mov  al,0     ;pagina principal(1 pantalla)
       mov  cx,0     ;borramos desde la posicion 0
       mov  dx,2479h ; hasta la posicion 2479h(es dcir toda la pantalla)
       mov  bh,7     ;con que color quiero que se quede el cursor(7=blanco,5=amarillo...)
       mov  ah,6
       int  10h
       pop  dx
       pop  cx
       pop  bx
       pop  ax
       ret
borrar endp   


ASCDEC proc near  ; pasa una cadena numerica en ALFANU a un valor hexadecimal en BINV
       
       push ax
       push bx
       push cx
       push dx
       push si
       push di
       
       mov  ax,0
       mov  bx,0
       mov  cx,10
       lea  si,ALFANU[2]
       
       
       ascdec1: cmp  [si],'$'
                je   ASCDEC2
                cmp  [si],13
                je   ASCDEC2
                mov  bl,[si]
                sub  bl,'0'
                mul  cx
                add  ax,bx
                inc  si
                jmp  ASCDEC1
       
       ascdec2: mov  BINV,al
                pop  di
                pop  si
                pop  dx
                pop  cx
                pop  bx
                pop  ax 
                
       ret
ASCDEC endp

DECASC proc near
       push ax
       push bx
       push cx
       push dx
       push si
       
       mov  ALFANU,'0'
       mov  ALFANU[1],'0'
       mov  ALFANU[2],'0'
       mov  ALFANU[3],'$'
       
       lea  si,ALFANU[2]
       mov  cx,10
       mov  ax,0
       mov   al,BINV

DECASC1: cmp ax,10
         jl  DECASC2
         mov dx,0
         mov dx,0
         div cx
         add dl,30h
         mov [si],bl
         dec si
         jmp DECASC2

DECASC2: add al,30h
         mov [si],al
         
         pop si
         pop dx
         pop cx
         pop bx
         pop ax
        
       

end start ; set entry point and stop the assembler.
