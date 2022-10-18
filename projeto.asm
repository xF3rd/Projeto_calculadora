.MODEL SMALL
.DATA
    msg1 db "1 - Soma",10,"2 - Subtracao",10,"3 - Multiplicacao",10,"4 - Divicao",10,"$"
    msg2 db "Qual operacao:",10,"$"
    msg3 db 10,"Primeiro numero: $"
    msg4 db 10,"Segundo numero: $"
    msg5 db 10,"Resultado:$"
    msg6 db 10,"Resultado com dois digitos?",10," 1 - Sim/2 - Nao$"



.CODE
    main PROC
        MOV AX,@DATA
        MOV ds,ax           ;inicia o DATA

        mov ah,09
        mov dx,offset msg2           ;printa a mensagem
        int 21h

        mov ah,09
        mov dx,offset msg1           ;printa a mensagem
        int 21h

        mov ah,01
        int 21h
        
        cmp al,031h
        je ADICAO

        cmp al,032h
        je SUBTRACAO2

        cmp al,033h
        jmp MULTIPLICACAO2

        cmp al,034h
        jmp DIVICAO

        ADICAO:

        mov ah,09
        mov dx,offset msg6           ;printa a mensagem
        int 21h

        mov ah,01
        int 21h

        cmp al,031h
        je DOISDIG

        mov ah,09
        mov dx,offset msg3           ;printa a mensagem
        int 21h

        mov ah,01
        int 21h

        mov bl,al

        mov ah,09
        mov dx,offset msg4           ;printa a mensagem
        int 21h

        mov ah,01
        int 21h

        and bl,0fh
        and al,0fh

        add al,bl
        add al,030h

        mov cl,al
        and cl,cl

        mov ah,09
        mov dx,offset msg5           ;printa a mensagem
        int 21h

        
        mov dl,cl
        mov ah,02
        int 21h

        jmp FIM

        SUBTRACAO2:
        jmp SUBTRACAO

        MULTIPLICACAO2:
        jmp MULTIPLICACAO

        DOISDIG:

        mov ah,09
        mov dx,offset msg3           ;printa a mensagem
        int 21h

        mov ah,01
        int 21h

        mov bl,al

        mov ah,09
        mov dx,offset msg4           ;printa a mensagem
        int 21h

        mov ah,01
        int 21h

        

        and bl,0fh
        and al,0fh

        add bl,al
        xor ax,ax
        mov al,bl
        
        mov dl,10
        div dl
        
        mov cl,ah
        mov bl,al
        mov ah,09
        mov dx,offset msg5           ;printa a mensagem
        int 21h

        

        add bl,030h
        mov dl,bl
        mov ah,02
        int 21h

        add cl,030h
        mov dl,cl
        mov ah,02
        int 21h

       

        

        
            
            
        SUBTRACAO:
            mov al,1

        MULTIPLICACAO:

        DIVICAO:




        FIM:
            mov ah,4ch
            int 21h

    main ENDP
end main