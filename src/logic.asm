
highlight_row:  push bp
                mov bp,sp
                push ax
                push bx
                push dx
                push si
                push di
                push es

                mov ax,0xb800
                mov es,ax
                xor bx,bx
                xor dx,dx
                mov ax,[bp+14]  ;active_pane
                cmp ax,0
                jz left_pane
                jmp right_pane

left_pane:      mov ax,[bp+12]
                mov bl,80
                mul bl
                mov dx,ax
                mov bx,[bp+10]  
                add ax,bx       ; ax contains the starting index
                shl ax,1
                mov bx,[bp+8]
                add dx,bx       ;dx contains the ending index
                shl dx,1
                mov si,ax
                mov di,dx
                jmp highlight_loop


right_pane:     mov ax,[bp+12]
                mov bl,80
                mul bl
                mov dx,ax
                mov bx,[bp+6]
                add ax,bx
                shl ax,1
                mov bx,[bp+4]
                add dx,bx
                shl dx,1
                mov si,ax
                mov di,dx
                jmp highlight_loop

highlight_loop: mov ax,[es:si]
                mov ah,31h
                mov [es:si],ax
                add si,2
                cmp si,di
                jle highlight_loop
                jmp return_highlight

return_highlight:       pop es
                        pop di
                        pop si
                        pop dx
                        pop bx
                        pop ax
                        pop bp
                        ret 12



unhighlight_row:  push bp
                mov bp,sp
                push ax
                push bx
                push dx
                push si
                push di
                push es

                mov ax,0xb800
                mov es,ax
                xor bx,bx
                xor dx,dx
                mov ax,[bp+14]  ;active_pane
                cmp ax,0
                jz unleft_pane
                jmp unright_pane

unleft_pane:      mov ax,[bp+12]
                mov bl,80
                mul bl
                mov dx,ax
                mov bx,[bp+10]  
                add ax,bx       ; ax contains the starting index
                shl ax,1
                mov bx,[bp+8]
                add dx,bx       ;dx contains the ending index
                shl dx,1
                mov si,ax
                mov di,dx
                jmp unhighlight_loop


unright_pane:     mov ax,[bp+12]
                mov bl,80
                mul bl
                mov dx,ax
                mov bx,[bp+6]
                add ax,bx
                shl ax,1
                mov bx,[bp+4]
                add dx,bx
                shl dx,1
                mov si,ax
                mov di,dx
                jmp unhighlight_loop

unhighlight_loop: mov ax,[es:si]
                mov ah,1Bh
                mov [es:si],ax
                add si,2
                cmp si,di
                jle unhighlight_loop
                jmp return_unhighlight

return_unhighlight:       pop es
                        pop di
                        pop si
                        pop dx
                        pop bx
                        pop ax
                        pop bp
                        ret 12

