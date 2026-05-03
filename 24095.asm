org 100h

call clscr
call blue_background
jmp exit




clscr:  push bp
        mov bp,sp
        push ax
        push es
        push di
        xor di,di
        mov ax,0xb800
        mov es,ax
        mov ax, 0x0020
        jmp clear_loop

clear_loop: mov [es:di],ax
            add di,2
            cmp di,4000
            jnz clear_loop
            jmp return_clscr

return_clscr:   pop di
                pop es
                pop ax
                pop bp
                ret


blue_background:    push bp
                    mov bp,sp
                    push ax
                    push di
                    push es
                    xor di,di
                    mov ax,0xb800
                    mov es,ax
                    mov ax,1020h
                    jmp background_loop

background_loop:    mov [es:di],ax
                    add di,2
                    cmp di,4000
                    jnz background_loop
                    jmp ret_back


ret_back:   pop es
            pop di
            pop ax
            pop bp
            ret




exit:   mov ah, 00h
        int 16h
        mov ax,4c00h
        int 21h