.MODEL SMALL
.DATA
    msg1 db "1 - Soma",10,"2 - Subtracao",10,"3 - Multiplicacao",10,"4 - Divicao",10,"$"
    msg2 db "Qual operacao:",10,"$"
    msg3 db 10,"Primeiro numero: $"
    msg4 db 10,"Segundo numero: $"
    msg5 db 10,"Resultado:$"
    msg6 db "-$"



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
        je SUBTRACAO

        cmp al,033h
        ;je MULTIPLICACAO

        cmp al,034h
        ;je DIVICAO

        ADICAO:
        
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

        jmp FIM
              
        SUBTRACAO:


            mov ah,09
            mov dx,offset msg3           ;printa a mensagem
            int 21h

            mov ah,01
            int 21h
            mov bl,al
            and bl,0fh

            mov ah,09
            mov dx,offset msg4           ;printa a mensagem
            int 21h

            mov ah,01
            int 21h
            and al,0fh

            cmp al,bl
            jge NEGATIVO

            sub bl,al

            add bl,030h


            mov ah,09
            mov dx,offset msg5           ;printa a mensagem
            int 21h

            mov dl,bl

            mov ah,02
            int 21h

            jmp FIM

        NEGATIVO:
            sub bl,al

            neg bl
            add bl,030h


            mov ah,09
            mov dx,offset msg5           ;printa a mensagem
            int 21h

            mov ah,09
            mov dx,offset msg6           ;printa a mensagem
            int 21h

            mov dl,bl

            mov ah,02
            int 21h

            jmp FIM



        MULTIPLICACAO:
            mov al,1


        DIVICAO:
            mov al,1

        




        FIM:
            mov ah,4ch
            int 21h

    main ENDP
end main