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
        je MULTIPLICACAO1
        MULTIPLICACAO1:
            jmp MULTIPLICACAO

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

            mov cl,al

            and al,01h
            jz PAR
            jnz IMPAR1

        IMPAR1:
            jmp IMPAR


        PAR:
            and bl,0fh
            and cl,0fh

            cmp cl,2
            je LOOP2

            cmp cl,4
            je LOOP4

            cmp cl,6
            je LOOP6

            cmp cl,8
            je LOOP8a

        LOOP8a:
            jmp LOOP8



        LOOP2:
            sub cl,1
            shl bl,cl
            mov ah,09
            mov dx,offset msg5           ;printa a mensagem
            int 21h


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
        
        LOOP4:
            sub cl,2
            shl bl,cl
            mov ah,09
            mov dx,offset msg5           ;printa a mensagem
            int 21h


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

            LOOP6:
            sub cl,4
            mov al,bl
            shl bl,cl
            add bl,al
            add bl,al

            mov ah,09
            mov dx,offset msg5           ;printa a mensagem
            int 21h


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

            LOOP8:
            sub cl,5
            shl bl,cl
            mov ah,09
            mov dx,offset msg5           ;printa a mensagem
            int 21h


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

        IMPAR:
            
            xor ax,ax
            mov al,bl
              
            dec cl
            shl bl,cl
            add bl,al

            mov ah,09
            mov dx,offset msg5           ;printa a mensagem
            int 21h

            mov dl,bl
            mov ah,02
            int 21h

            jmp FIM

        DIVICAO:
            mov al,1

        




        FIM:
            mov ah,4ch
            int 21h

    main ENDP
end main