

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
                jmp extract_name    ; name is 13 bytesa

extract_name:   mov ax,file_list
                push ax
                mov ax,0x07
                push ax
                mov ax,2
                push ax
                mov ax,3
                push ax
                call print
                jmp return_file_extract

return_file_extract:    pop es
                        pop si
                        pop di
                        pop bx
                        pop ax
                        pop bp
                        ret