

file_extract:   push bp 
                mov bp,sp
                push ax
                push bx
                push di
                push si
                push es
                mov ax,0xb800
                mov es,ax
                xor ax,ax
                xor si,si
                xor di,di
                mov si,file_list
                jmp extract_name    ; name is 13 bytesa

extract_name:   mov ax,si
                push ax
                mov ax,0x1B
                push ax
                mov ax,2
                push ax
                mov ax,1
                push ax
                call print
                jmp extract_size

extract_size:   mov ax,[si+14]
                push ax
                mov ax,[si+16]
                push ax
                mov ax,0x1B
                push ax
                mov ax,2
                push ax
                mov ax,21
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
                mov ax,2
                push ax
                mov ax,31
                push ax
                call print_number

@leading_here:  mov ax,[si+18]
                shr ax,5
                and ax, 000Fh

                cmp ax,10
                jl print_leading_zero2
                push ax
                mov ax,0
                push ax
                mov ax,0x1B
                push ax
                mov ax,2
                push ax
                mov ax,34
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
                mov ax,2
                push ax
                mov ax,37
                push ax
                call print_number
                jmp print_dashes

return_file_extract:    pop es
                        pop si
                        pop di
                        pop bx
                        pop ax
                        pop bp
                        ret



print_leading_zero1: xor ax,ax
                    mov ax,30h
                    push ax
                    mov ax,0x1B
                    push ax
                    mov ax,2
                    push ax
                    mov ax,31
                    push ax
                    call print_character


                    mov ax,[si+18]
                    and ax,001Fh
                    push ax
                    mov ax,0
                    push ax
                    mov ax,0x1B
                    push ax
                    mov ax,2
                    push ax
                    mov ax,32
                    push ax
                    call print_number
                    jmp @leading_here


print_leading_zero2: xor ax,ax
                    mov ax,30h
                    push ax
                    mov ax,0x1B
                    push ax
                    mov ax,2
                    push ax
                    mov ax,34
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
                    mov ax,2
                    push ax
                    mov ax,35
                    push ax
                    call print_number
                    jmp @leading_here2

print_dashes:   xor ax,ax   
                mov ax,0x2D
                push ax
                mov ax,0x1B
                push ax
                mov ax,2
                push ax
                mov ax,33
                push ax
                call print_character

                xor ax,ax   
                mov ax,0x2D
                push ax
                mov ax,0x1B
                push ax
                mov ax,2
                push ax
                mov ax,36
                push ax
                call print_character
                jmp return_file_extract
