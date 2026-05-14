view_file:  call blue_background
            mov dx,si
            add dx,bx

            ;open file
            mov ah,3Dh
            mov al,0
            int 21h
            jc file_error
            mov [file_handle],ax


reading_loop:
            ;read file
            mov ah,3Fh
            mov bx,[file_handle]
            mov cx,2000     ;asks for how much to draw on screen
            mov dx,file_buffer
            int 21h
            
            ; Add null-terminator so print stops at the correct length
            mov bx, ax
            mov byte [file_buffer + bx], 0

            mov bx, ax      ; SAVE AX before we ruin it

            mov ax,file_buffer
            push ax
            mov ax,[attribute]
            push ax
            mov ax,0
            push ax
            mov ax,0
            push ax
            call print

            cmp bx,0        ; CHECK BX instead of AX
            jg next_page

            mov ah,00h
            int 16h



            ;close file
close_file: mov ah,3Eh
            mov bx,[file_handle]     
            int 21h    ; YOU FORGOT TO CALL DOS!
            jmp ret_view_file
            

next_page:  mov ah,00h
            int 16h

            cmp al,1Bh        
            je close_file

            cmp ah,50h      ; 50h is the DOWN arrow key
            je reading_loop


file_error: pop si
            pop dx
            pop cx
            pop bx
            pop ax
            jmp main_loop

ret_view_file:  pop si
                pop dx
                pop cx
                pop bx
                pop ax
                jmp refresh_screens
                ; these are all from enter_directory