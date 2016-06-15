; multi-segment executable file template.

data segment
    ; add your data here!
    msj1 db 'introduce un numero $'
    msj2 db 10,13, 'el resultado es: '
    num  db 0
         db '$'
    
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
            
    ;mov ah,1 ;estas 2 instrucciones son para pedir un numero por pantalla,se almacena en al
    ;int 21h
    ;sub al,'0' ;resto 0 ascii para tener el resultado en alfanumerico 
    
    lea dx,msj1
    mov ah,9
    int 21h
    
    call leerdatos
    call calcular
    call escribir
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

leerdatos proc near
    
          push ax
          mov ah,1
          int 21h
          sub al,'0'
          mov num,al
          pop ax
          ret
leerdatos endp


calcular proc near
    
         push ax
         push bx
         mov ah,0
         mov al,2
         mul num
         mov num,al
         pop bx
         pop ax
         ret
calcular endp
 
          
          

escribir  proc near
    
          push ax
          push dx
          add num,'0'
          
          lea dx,msj2
          mov ah,9
          int 21h
          pop dx
          pop ax 
          ret
escribir  endp
    

end start ; set entry point and stop the assembler.
