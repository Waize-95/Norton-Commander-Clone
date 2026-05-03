org 100h

;call clscr
call blue_background
call boundry


mov ax,Mystr1
push ax
mov ax,[attribute]
push ax
mov ax,[row1]
push ax
mov ax,[cols1]
push ax
call print


mov ax,Mystr2
push ax
mov ax,[attribute]
push ax
mov ax,[row2]
push ax
mov ax,[cols2]
push ax
call print


mov ax,Mystr3
push ax
mov ax,[attribute]
push ax
mov ax,[row3]
push ax
mov ax,[cols3]
push ax
call print

mov ax,Mystr1
push ax
mov ax,[attribute]
push ax
mov ax,[row4]
push ax
mov ax,[cols4]
push ax
call print

mov ax,Mystr2
push ax
mov ax,[attribute]
push ax
mov ax,[row5]
push ax
mov ax,[cols5]
push ax
call print

mov ax,Mystr3
push ax
mov ax,[attribute]
push ax
mov ax,[row6]
push ax
mov ax,[cols6]
push ax
call print







mov ax,[Mychar]
push ax
mov ax,[attr]
push ax
mov ax,[v_row1]
push ax
mov ax,[v_cols1]
push ax
mov ax,[dest_row1]
push ax
call print_verticle

mov ax,[Mychar]
push ax
mov ax,[attr]
push ax
mov ax,[v_row2]
push ax
mov ax,[v_cols2]
push ax
mov ax,[dest_row2]
push ax
call print_verticle


mov ax,[Mychar]
push ax
mov ax,[attr]
push ax
mov ax,[v_row3]
push ax
mov ax,[v_cols3]
push ax
mov ax,[dest_row3]
push ax
call print_verticle


mov ax,[Mychar]
push ax
mov ax,[attr]
push ax
mov ax,[v_row4]
push ax
mov ax,[v_cols4]
push ax
mov ax,[dest_row4]
push ax
call print_verticle


mov ax,[h_Mychar]
push ax
mov ax,[h_attr]
push ax
mov ax,[h_row]
push ax
mov ax,[h_cols]
push ax
mov ax,[dest_col]
push ax
call print_horizontal



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


boundry:  push bp
        mov bp,sp
        push ax
        push es
        push di
        push si
        mov ax,0xb800
        mov es,ax
        xor di,di
        mov ax,0x1BCD
        jmp upper_loop


upper_loop:     mov [es:di],ax
                add di,2
                cmp di,160
                jnz upper_loop
                sub di,2
                mov ax,0x1BBA
                jmp right_loop

right_loop:     mov [es:di],ax
                add di,160
                cmp di,4000
                jl right_loop
                sub di,160
                mov ax,0x1BCD
                jmp down_loop

down_loop:      mov [es:di],ax
                sub di,2
                cmp di,0x0F00
                jge down_loop
                add di,2
                mov ax,0x1BBA
                jmp left_loop

left_loop:      mov [es:di],ax
                sub di,160
                cmp di,0
                jg left_loop
                ; correcting borders, i think if i first compare in loop and make the borders in loop
                ; that would be more computationaly expensive
                mov di,0        ; top left
                mov ax,0x1BC9   
                mov [es:di],ax
                mov di,158      ; top right
                mov ax,0x1BBB
                mov [es:di],ax
                mov di,3998     ; bottom right
                mov ax,0x1BBC
                mov [es:di],ax
                mov di,0x0F00   ;bottom left
                mov ax,0x1BC8
                mov [es:di],ax
                jmp panes

panes:  mov di,80
        mov si,78
        mov ax,1BBAh
@here   mov [es:si],ax
        mov [es:di],ax
        add si,160
        add di,160
        cmp di,0x0F00
        jle @here
        ; now correcting the boundries of the panes
        mov di,78       ; for the ╗ of left pane
        mov ax,0x1BBB
        mov [es:di],ax
        add di,2        ; for the ╔ of right pane
        mov ax,0x1BC9
        mov [es:di],ax
        mov di,0x0F4E   ; for the boundry of first pane's bottom right
        mov ax,0x1BBC
        mov [es:di],ax
        add di,2        ; for the boundry of second pane's bottom left
        mov ax,0x1BC8
        mov [es:di],ax
        jmp return_boundry

return_boundry: pop si
                pop di
                pop es
                pop ax
                pop bp
                ret



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













exit:   mov ah, 00h
        int 16h
        mov ax,4c00h
        int 21h


Mystr1: db "Name",0
attribute: db 0x1E
row1:  db 1
cols1: db 8


Mystr2: db "Size",0
row2:  db 1
cols2: db 24 


Mystr3: db "Date",0
row3:  db 1
cols3: db 33

row4: db 1  
cols4: db 48

row5: db 1
cols5: db 64

row6: db 1
cols6: db 73


Mychar: db 0xB3
attr: db 0x1B

v_row1: db 1
v_cols1: db 30
dest_row1: db 22


v_row2: db 1
v_cols2: db 20
dest_row2: db 22


v_row3: db 1
v_cols3: db 70
dest_row3: db 22

v_row4: db 1
v_cols4: db 60
dest_row4: db 22




h_Mychar: db 0xC4
h_attr: db 0x1B
h_row: db 22
h_cols: db 1
dest_col: db 78
