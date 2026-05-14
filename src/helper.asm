
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


print_number:   push bp
                mov bp,sp
                push ax
                push bx
                push cx
                push dx
                push si
                push di
                push es
                mov ax,0xb800
                mov es,ax

                xor ax,ax
                xor bx,bx
                xor cx,cx
                xor si,si
                xor di,di

                mov ax,[bp+6]   ;row
                mov bl,80
                mul bl
                mov bx,[bp+4]   ;column
                add ax,bx
                shl ax,1        ; the point at which we have to print
                mov di,ax

                mov ax,[bp+12]  ; as the number can be 32 byte, half will be in ax and other half in dx
                mov dx,[bp+10]  ; the higher number
                mov bx,10
                jmp push_loop

push_loop:      mov ax,[bp+10]  ;  the issue why we were not able to print the file with bigger sizes was 
                xor dx,dx       ;  here, previously we did division now we are doing long division
                div bx          ;  the upper byte gets divided the remainder is stored in dx, adn the rest of the 
                mov [bp+10],ax  ;  the number(LOWER BYTE) is stored in AX just like we do in long division.

                mov ax,[bp+12]
                div bx
                mov [bp+12],ax

                add dx,0x30
                push dx
                inc cx

                cmp word [bp+10],0
                jne push_loop

                cmp word [bp+12],0
                jne push_loop

                jmp num_printing

num_printing:   pop ax
                mov ah,[bp+8]
                mov [es:di],ax
                add di,2
                sub cx,1
                jnz num_printing
                jmp return_num

return_num:     pop es
                pop di
                pop si
                pop dx
                pop cx
                pop bx
                pop ax
                pop bp
                ret 10



print_character:        push bp
                        mov bp,sp
                        push ax
                        push bx
                        push di
                        push es
                        xor bx,bx
                        xor ax,ax
                        xor di,di
                        mov ax,0xb800
                        mov es,ax

                        mov ax,[bp+6]   ;row
                        mov bl,80
                        mul bl
                        mov bx,[bp+4]   ;col
                        add ax,bx
                        shl ax,1
                        mov di,ax
                        mov bx,[bp+8]   ;attribute
                        mov ah,bl
                        mov bx,[bp+10]  ; char
                        mov al,bl

                        mov [es:di],ax
                        jmp return_print_character

return_print_character: pop es
                        pop di
                        pop bx
                        pop ax
                        pop bp
                        ret 8



