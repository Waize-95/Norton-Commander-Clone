
print:  push bp
        mov bp,sp
        push ax
        push bx
        push si
        push di
        push es
        xor si,si
        xor di,di
        mov ax,0xb800
        mov es,ax
        xor ax,ax
        xor bx,bx
        
        mov si,[bp+10]
        mov bl,80
        mov al,[bp+6]
        mul bl
        mov bl,[bp+4]
        add ax,bx
        shl ax,1
        mov di,ax
        xor ax,ax
        mov ah,[bp+8]
        jmp print_loop

print_loop:     mov al,[si]
                cmp al,0
                jz return_print
                mov [es:di],ax
                inc si
                add di,2
                jmp print_loop

return_print:   pop es
                pop di
                pop si
                pop bx
                pop ax
                pop bp
                ret 8


print_verticle: push bp
                mov bp,sp
                push ax
                push bx
                push di
                push es
                mov ax,0xb800
                mov es,ax
                xor ax,ax
                xor bx,bx

                ; calculated the position of the source from where we have to start printing
                mov al,[bp+8]
                mov bl,80
                mul bl
                mov bl,[bp+6]
                add ax,bx
                shl ax,1
                mov di,ax

                xor ax,ax
                xor bx,bx

               ; calculated the position of the destination uptil where we have to print
                mov al,[bp+4]
                mov bl,80
                mul bl
                mov bl,[bp+6]
                add ax,bx
                shl ax,1
                mov bx,ax
                
                ; moved the character and the attribute in the ax register
                mov al,[bp+12]
                mov ah,[bp+10]
                jmp vert_loop

vert_loop:      mov [es:di],ax
                add di,160
                cmp di,bx
                jle vert_loop
                jmp return_vert

return_vert:    pop es
                pop di
                pop bx
                pop ax
                pop bp
                ret 10




print_horizontal:       push bp
                        mov bp,sp
                        push ax
                        push bx
                        push di
                        push es
                        mov ax,0xb800
                        mov es,ax
                        xor ax,ax
                        xor bx,bx

                        ; calculated the position of the source from where we have to start printing
                        mov al,[bp+8]
                        mov bl,80
                        mul bl
                        mov bl,[bp+6]
                        add ax,bx
                        shl ax,1
                        mov di,ax

                        xor ax,ax
                        xor bx,bx

                        ;calculated the position of the destination uptil where we have to print
                        mov al,[bp+8]
                        mov bl,80
                        mul bl
                        mov bl,[bp+4]
                        add ax,bx
                        shl ax,1
                        mov bx,ax
                
                        ; moved the character and the attribute in the ax register
                        mov al,[bp+12]
                        mov ah,[bp+10]
                        jmp hori_loop

hori_loop:      mov [es:di],ax
                add di,2
                cmp di,bx
                jle hori_loop
                jmp return_hori

return_hori:    pop es
                pop di
                pop bx
                pop ax
                pop bp
                ret 10
