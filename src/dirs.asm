load_directories:   push ax
                    push bx
                    push cx
                    push dx
                    push si
                    push di

                    mov ah, 1Ah             ; "Hello DOS, I want to use extension 1Ah (Set DTA)"
                    mov dx, dta_buffer      ; "Here is the memory address of my 43-byte mailbox"
                    int 21h                 ; CALL DOS! DOS registers the address and returns instantly.

                    mov ah, 4Eh             ; "Hello DOS, extension 4Eh (Find First File) please"
                    mov cx, 10h             ; "I am looking for Normal Files AND Directories (10h)"
                    mov dx, search_string   ; "Here is my search query: *.*"
                    int 21h                 ; CALL DOS! (DOS spins the hard drive and fills the DTA)

                    ; SAFETY CHECK
                    jc return_dirs        ; "jc" means Jump if Carry. If the hard drive is empty or 
                                            ; broken, DOS sets the Carry Flag to 1. We jump to the end.

                    xor si,si
                    xor di,di
                    mov di,file_list
                    xor bx,bx

copy_loop:  mov al,[dta_buffer+21]  ;attribute
            mov [di+13],al

            mov ax,[dta_buffer+22]
            mov [di+20],ax

            mov ax,[dta_buffer+24]
            mov [di+18],ax

            mov ax,[dta_buffer+26]
            mov [di+14],ax

            mov ax,[dta_buffer+28]
            mov [di+16],ax

            mov si,dta_buffer+30
            mov cx,13
            push di
            jmp name_loop
            

name_loop:  mov al,[si]
            mov [di],al
            inc si
            inc di
            sub cx,1
            jnz name_loop

            pop di

            add di,32
            inc bx

            cmp bx,20
            je end_marker

            mov ah,4Fh
            int 21h
            jnc copy_loop
            jmp end_marker


end_marker: mov al,0FFh
            mov [di],al

return_dirs:    pop di
                pop si
                pop dx
                pop cx
                pop bx
                pop ax
                ret
    

