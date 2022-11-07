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
            and al,0fh                    ;transforma ascii em numero

            add bl,al                      ;realiza a soma
            xor ax,ax                      ;limpa o ax
            mov al,bl                      ;joga o resultado em al
        
            mov dl,10                       ; divide o resultado para conseguir imprimir numero com dois digitos
            div dl
        
            mov cl,ah
            mov bl,al

            mov ah,09
            mov dx,offset msg5           ;printa a mensagem
            int 21h

        

            add bl,030h
            mov dl,bl                    ;transforma e printa o resultado
            mov ah,02
            int 21h

            add cl,030h
            mov dl,cl
            mov ah,02                   ;transforma e printa o resultado
            int 21h

            jmp FIM                     ;pula para o fim do programa
              
        SUBTRACAO:


            mov ah,09
            mov dx,offset msg3           ;printa a mensagem
            int 21h

            mov ah,01
            int 21h
            mov bl,al                   ;pega numero do usuario e transforma
            and bl,0fh

            mov ah,09
            mov dx,offset msg4           ;printa a mensagem
            int 21h

            mov ah,01
            int 21h                     ;pega numero do usuario e transforma        
            and al,0fh

            cmp al,bl                   ;compara o segundo numero com o primeiro
            jge NEGATIVO                ;se o segundo numero for maior entao o resultado e negativo, pula para resolver isso

            sub bl,al                   ;subtrai os numeros

            add bl,030h                 ;transforma em ascii


            mov ah,09
            mov dx,offset msg5           ;printa a mensagem
            int 21h

            mov dl,bl

            mov ah,02
            int 21h                         ;printa o resultado

            jmp FIM                     ;pula para o fim do programa

        NEGATIVO:
            sub bl,al                   ;subtrai os numeros

            neg bl                      ;inverte o numero
            add bl,030h                 ;trasforma em ascii


            mov ah,09
            mov dx,offset msg5           ;printa a mensagem
            int 21h

            mov ah,09
            mov dx,offset msg6           ;printa a mensagem
            int 21h

            mov dl,bl

            mov ah,02                      ;printa o resultado
            int 21h

            jmp FIM                     ;pula para o fim do programa



        MULTIPLICACAO:

            mov ah,09
            mov dx,offset msg3           ;printa a mensagem
            int 21h

            mov ah,01
            int 21h                       ;pega numero do usuario e transforma
            mov bl,al
            and bl,0fh

            mov ah,09
            mov dx,offset msg4           ;printa a mensagem
            int 21h

            mov ah,01
            int 21h                     ;pega numero do usuario e transforma
            mov cl,al
            and cl,0fh

            cmp cl,9                    ;compara com nove
            je NOVE1

            
            cmp cl,4
            jg MAIOR4_2                 ;ve se o numero e maior que 4

            cmp cl,4
            jle ME_IG_4                 ;ve se o numero e menor igual a que 4


            MAIOR4_2:
                jmp MAIOR4              ;como je tem limite de distancia e presciso pular para jmp especifico 

            NOVE1:
                jmp NOVE                 ;como je tem limite de distancia e presciso pular para jmp especifico

            ME_IG_2:

                cmp cl,0        
                je ZERO                 ;compara com zero e pula se for

                mov bh,bl                ;salva o numero    
                shl bl,1                ;anda com o numero 1 vezes para esquerda
                xor ax,ax               ;limpa ax

                mov al,2                
                mov dl,cl                ;divide 2 pelo numero multiplicado
                div dl
                
                cmp al,2                 ;compara o resultado com dois
                je PULA2   
                
                cmp ah,0                 ;compara o resto com 0
                je PULA

               
                PULA2:
                    sub bl,bh           ;subtrai o numero mexido por ele inicialmente

                PULA:
                    xor ax,ax
                    mov al,bl
                    mov dl,10           ; divide o resultado para conseguir imprimir numero com dois digitos
                    div dl

                    mov bl,al
                    mov bh,ah

                    mov ah,09
                    mov dx,offset msg5           ;printa a mensagem
                    int 21h
                
                    mov dl,bl
                    add dl,30h                   ;transforma e printa o resultado
                    mov ah,02
                    int 21h

                    mov dl,bh
                    add dl,30h                    ;transforma e printa o resultado
                    mov ah,02
                    int 21h
                    jmp FIM                     ;pula para o fim do programa
            
            ZERO:

                mov ah,09
                mov dx,offset msg5           ;printa a mensagem
                int 21h

                mov dl,30h
                mov ah,02                   ;printa 0
                int 21h
                jmp FIM

            ME_IG_4:
                cmp cl,2            ;compara com 2
                jle ME_IG_2         ;pula se for menor igual a 2

                mov bh,bl           ;salva o numero
                shl bl,2            ;anda com o numero 2 vezes para esquerda
                xor ax,ax           ;limpa ax
                mov al,4        
                mov dl,cl           ;divide 4 pelo numero multiplicado
                div dl
                cmp ah,0            ;verifica se o resto e 0
                je PULA3            ;pula se for 0 
                VOLTA2:
                    sub bl,bh
                    dec ah          ;subtrai o numero mudado por ele inicial,faz n vezes igual ao resto
                    cmp ah,0    
                    jne VOLTA2
            PULA3:
                xor ax,ax
                mov al,bl           ; divide o resultado para conseguir imprimir numero com dois digitos
                mov dl,10
                div dl

                mov bl,al
                mov bh,ah

                mov ah,09
                mov dx,offset msg5           ;printa a mensagem
                int 21h
                
                mov dl,bl
                add dl,30h                    
                mov ah,02                   ;transforma e printa o resultado
                int 21h

                mov dl,bh
                add dl,30h                  ;transforma e printa o resultado
                mov ah,02
                int 21h

                jmp FIM                 ;pula para o fim do programa


            MAIOR4:
                mov bh,bl               ;salva o numero inicial
                shl bl,3                ;anda com o numero 3 vezes para esquerda
                xor ax,ax
                mov al,8
                mov dl,cl                ;divide 8 pelo numero multiplicado
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
                jmp FIM                         ;pula para o fim do programa

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
                jmp FIM                 ;pula para o fim do programa
            

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

                jmp FIM                     ;pula para o fim do programa


                

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

                    jmp FIM                     ;pula para o fim do programa    

                ERRADO:
                    mov ah,09
                    mov dx,offset msg9           ;printa a mensagem
                    int 21h

                    jmp NOVAMENTE                   

    FIM:
        mov ah,4ch          ;fenaliza o programa 
        int 21h

    main ENDP
end main