.MODEL SMALL
.DATA
    msg1 db "1 - Soma",10,"2 - Subtracao",10,"3 - Multiplicacao",10,"4 - Divicao",10,"$"
    msg2 db "Qual operacao:",10,"$"
    msg3 db 10,"Primeiro numero: $"
    msg4 db 10,"Segundo numero: $"
    msg5 db 10,"Resultado:$"
    msg6 db "-$"
    msg7 db 10,"Resultado: 0$"
    msg8 db 10,"Resultado: 1$"
    msg9 db 10,"Nao existe divisao por zero ",10,"Tente novamente$"
    msg10 db 10,"Resto:$"
    




.CODE
    main PROC
        MOV AX,@DATA
        MOV ds,ax   ;inicia o DATA

        mov ah,09
        mov dx,offset msg2           ;printa a mensagem
        int 21h

        mov ah,09
        mov dx,offset msg1           ;printa a mensagem
        int 21h

        mov ah,01                     ;pega numero do usuario
        int 21h
        
        cmp al,031h
        je ADICAO

        cmp al,032h
        je SUBTRACAO                   ;faz comparacoes para saber qual operacao foi escolhida 

        cmp al,033h
        je MULTIPLICACAO1
        

        cmp al,034h
        je DIVICAO1

        MULTIPLICACAO1:
        
        
            jmp MULTIPLICACAO           ;como je tem limite de distancia e presciso pular para jmp especifico para ai sim ir para a operaçao em si

        DIVICAO1:
            jmp DIVICAO                 ;como je tem limite de distancia e presciso pular para jmp especifico para ai sim ir para a operaçao em si

        ADICAO:
        
            mov ah,09
            mov dx,offset msg3           ;printa a mensagem
            int 21h

            mov ah,01                     ;pega numero do usuario
            int 21h

            mov bl,al

            mov ah,09
            mov dx,offset msg4           ;printa a mensagem
            int 21h

            mov ah,01                    ;pega numero do usuario
            int 21h

        

            and bl,0fh
            and al,0fh                    ;transforrma ascii em numero

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
            and bl,0fh

            mov ah,09
            mov dx,offset msg4           ;printa a mensagem
            int 21h

            mov ah,01
            int 21h

            mov cl,al
            and cl,0fh

            cmp cl,9
            je NOVE1

            
            cmp cl,4
            jg MAIOR4_2

            cmp cl,4
            jle ME_IG_4


            MAIOR4_2:
                jmp MAIOR4

            NOVE1:
                jmp NOVE

            ME_IG_2:

                cmp cl,0
                je ZERO

                mov bh,bl
                shl bl,1
                xor ax,ax
                mov al,2
                mov dl,cl
                div dl
                
                cmp al,2
                je PULA2   
                
                cmp ah,0
                je PULA

               
                PULA2:
                    sub bl,bh
                    dec ah
                

                PULA:
                    xor ax,ax
                    mov al,bl
                    mov dl,10
                    div dl

                    mov bl,al
                    mov bh,ah

                    mov ah,09
                    mov dx,offset msg5           ;printa a mensagem
                    int 21h
                
                    mov dl,bl
                    add dl,30h
                    mov ah,02
                    int 21h

                    mov dl,bh
                    add dl,30h
                    mov ah,02
                    int 21h
                    jmp FIM
            
            ZERO:

                mov ah,09
                mov dx,offset msg5           ;printa a mensagem
                int 21h

                mov dl,30h
                mov ah,02
                int 21h
                jmp FIM

            ME_IG_4:
                cmp cl,2
                jle ME_IG_2

                mov bh,bl
                shl bl,2
                xor ax,ax
                mov al,4
                mov dl,cl
                div dl
                VOLTA2:
                    sub bl,bh
                    dec ah
                    cmp ah,0
                    jne VOLTA2

                xor ax,ax
                mov al,bl
                mov dl,10
                div dl

                mov bl,al
                mov bh,ah

                mov ah,09
                mov dx,offset msg5           ;printa a mensagem
                int 21h
                
                mov dl,bl
                add dl,30h
                mov ah,02
                int 21h

                mov dl,bh
                add dl,30h
                mov ah,02
                int 21h
                jmp FIM


            MAIOR4:
                mov bh,bl
                shl bl,3
                xor ax,ax
                mov al,8
                mov dl,cl
                div dl

                VOLTA:
                    sub bl,bh
                    dec ah
                    cmp ah,0
                    jne VOLTA

                xor ax,ax
                mov al,bl
                mov dl,10
                div dl

                mov bl,al
                mov bh,ah

                mov ah,09
                mov dx,offset msg5           ;printa a mensagem
                int 21h
                
                mov dl,bl
                add dl,30h
                mov ah,02
                int 21h

                mov dl,bh
                add dl,30h
                mov ah,02
                int 21h
                jmp FIM

            NOVE:

                mov bh,bl
                shl bl,3
                add bl,bh

                xor ax,ax
                mov al,bl
                mov dl,10
                div dl

                mov bl,al
                mov bh,ah

                mov ah,09
                mov dx,offset msg5           ;printa a mensagem
                int 21h
                
                mov dl,bl
                add dl,30h
                mov ah,02
                int 21h

                mov dl,bh
                add dl,30h
                mov ah,02
                int 21h
                jmp FIM
            



        DIVICAO:

            NOVAMENTE:
                
                mov ah,09
                mov dx,offset msg3           ;printa a mensagem
                int 21h

                mov ah,01
                int 21h                        ;pega primeiro numero
                mov bl,al
                and bl,0fh

                mov ah,09
                mov dx,offset msg4              ;printa a mensagem
                int 21h

                mov ah,01
                int 21h                        ;pega segundo numero

                mov cl,al
                and cl,0fh

                cmp cl,bl
                jg ZERO_DIV

                cmp cl,0
                je ERRADO

                mov dh,cl       ;<---- move o divisor para dh

                xor ax,ax       ;<---- zera ax para armazenar o dividendo
                mov al,bl       ;<---- move o dividendo para al
                xor dl,dl       ;<---- zera dl para poder manipular o divisor 
                xor bx,bx       ;<---- zera bx para armazenar o resultado



                mov cx,9       ;<----- adiciona 9 no contador para trabalhar com 9 bits

                DIV_1:
                sub ax,dx      ;<----- subtrai divisor do dividendo
                jns MENOS_1      ;<----- se o resultado da divisão não for negativo não reverte o processo
                add ax,dx      ;<----- reverte o processo 
                mov bh,0       ;<----- adiciona 0 nos bits do resultado
                jmp MENOS_2      ;<----- pula para 

                MENOS_1:
                mov bh,1       ;<----- adiciona 1 nos bits do resultado

                MENOS_2:
                shl bl,1       ;<----- desloca resultado 1 casa para esquerda
                or bl,bh       ;<----- adicina bit (0 ou 1) na casa certa
                shr dx,1       ;<----- desloca divisor uma casa para direita
                loop DIV_1      ;<----- refaz procediemento até cx ser igual a zero
                mov ch,al      ;<----- move o resto para ch

                mov ah,09
                mov dx,offset msg5           ;printa a mensagem
                int 21h

                mov dl,bl
                add dl,030h
                mov ah,02
                int 21h
                

                mov ah,09
                mov dx,offset msg10           ;printa a mensagem
                int 21h
                mov dl,ch
                add dl,030h
                mov ah,02
                int 21h

                jmp FIM


                

                ZERO_DIV:

                    mov ah,09
                    mov dx,offset msg7           ;printa a mensagem
                    int 21h


                    mov ah,09
                    mov dx,offset msg10           ;printa a mensagem
                    int 21h

                    mov dl,bl
                    add dl,030h
                    mov ah,02
                    int 21h

                    jmp FIM

                ERRADO:
                    mov ah,09
                    mov dx,offset msg9           ;printa a mensagem
                    int 21h

                    jmp NOVAMENTE

    FIM:
        mov ah,4ch
        int 21h

    main ENDP
end main