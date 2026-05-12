

file_extract:   push bp 
                mov bp,sp
                push ax
                push bx
                push cx
                push dx
                push di
                push si
                push es
                mov ax,0xb800
                mov es,ax
                xor ax,ax
                xor si,si
                xor di,di
                mov di,[bp+4]      ; screen column for this pane
                mov cx,2
                mov ax,[bp+6]      ; explicit pane index (0 = left, 1 = right)
                cmp ax,0
                jne second_pane_ext
                mov si,left_file_list
                jmp extract_loop    ; name is 13 bytes

second_pane_ext:    mov si,right_file_list
                    jmp extract_loop

extract_loop:   mov al,[si]
                cmp al,0FFh ; is this the end?
                je near return_file_extract

                cmp cx,22   ; have we hit the end row
                je near return_file_extract

                jmp extract_name

extract_name:   mov ax,si
                push ax
                mov ax,0x1B
                push ax
                mov ax,cx
                push ax
                mov ax,di
                push ax
                call print
                jmp extract_size

extract_size:   mov ax,[si+14]
                push ax
                mov ax,[si+16]
                push ax
                mov ax,0x1B
                push ax
                mov ax,cx
                push ax
                mov ax,di
                add ax,20
                push ax
                call print_number
                jmp extract_date

extract_date:   mov ax,[si+18]
                and ax,001Fh

                cmp ax,10
                jl print_leading_zero1
                push ax
                mov ax,0
                push ax
                mov ax,0x1B
                push ax
                mov ax,cx
                push ax
                mov ax,di
                add ax,30
                push ax
                call print_number

@leading_here:  mov ax,[si+18]
                shr ax,5
                and ax, 000Fh

                cmp ax,10
                jl near print_leading_zero2
                push ax
                mov ax,0
                push ax
                mov ax,0x1B
                push ax
                mov ax,cx
                push ax
                mov ax,di
                add ax,33
                push ax
                call print_number

@leading_here2: mov ax,[si+18]
                shr ax,9
                and ax,007FH
                sub ax,20     ;years since 1980
                push ax
                mov ax,0
                push ax
                mov ax,0x1B
                push ax
                mov ax,cx
                push ax
                mov ax,di
                add ax,36
                push ax
                call print_number
                jmp print_dashes
@return_from_dashes:    add si,32
                        inc cx
                        jmp extract_loop                


return_file_extract:    pop es
                        pop si
                        pop di
                        pop dx
                        pop cx
                        pop bx
                        pop ax
                        pop bp
                        ret 4



print_leading_zero1: xor ax,ax
                    mov ax,30h
                    push ax
                    mov ax,0x1B
                    push ax
                    mov ax,cx
                    push ax
                    mov ax,di
                    add ax,30
                    push ax
                    call print_character


                    mov ax,[si+18]
                    and ax,001Fh
                    push ax
                    mov ax,0
                    push ax
                    mov ax,0x1B
                    push ax
                    mov ax,cx
                    push ax
                    mov ax,di
                    add ax,31
                    push ax
                    call print_number
                    jmp @leading_here


print_leading_zero2: xor ax,ax
                    mov ax,30h
                    push ax
                    mov ax,0x1B
                    push ax
                    mov ax,cx
                    push ax
                    mov ax,di
                    add ax,33
                    push ax
                    call print_character

                    mov ax,[si+18]
                    shr ax,5
                    and ax, 000Fh
                    push ax
                    mov ax,0
                    push ax
                    mov ax,0x1B
                    push ax
                    mov ax,cx
                    push ax
                    mov ax,di
                    add ax,34
                    push ax
                    call print_number
                    jmp @leading_here2

print_dashes:   xor ax,ax   
                mov ax,0x2D
                push ax
                mov ax,0x1B
                push ax
                mov ax,cx
                push ax
                mov ax,di
                add ax,32
                push ax
                call print_character

                xor ax,ax   
                mov ax,0x2D
                push ax
                mov ax,0x1B
                push ax
                mov ax,cx
                push ax
                mov ax,di
                add ax,35
                push ax
                call print_character
                jmp @return_from_dashes
