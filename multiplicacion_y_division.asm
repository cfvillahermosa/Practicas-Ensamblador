; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "Carlos$" 
    var1 db 0
    var2 db 0
    var3 dw 0
    numero db 10
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
    
    mov var1,5
    mov var2,7
    mov al,var1   ;multiplicacion 5*7 y almacenamos el resultado en var3
    mul var2
    mov var3,ax 
    
    mov ax,21
    mov bl,numero  ;dividimos 21:10 (el cociente queda en AL y el resto en AH) 
    div bl
            

    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
