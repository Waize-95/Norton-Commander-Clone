org 100h
jmp start

start:  

        mov ah, 47h
        mov dl, 0
        mov si, left_path + 1
        int 21h

        mov ah, 47h
        mov dl, 0
        mov si, right_path + 1
        int 21h

        mov byte [active_pane],1
        call load_directories

        mov byte [active_pane],0
        call load_directories

refresh_screens:


        call initialize_ui
        mov ax,0                ; pane index: left pane
        push ax
        mov ax,1                ; screen column: left pane
        push ax
        call file_extract

        mov ax,1                ; pane index: right pane
        push ax
        mov ax,41               ; screen column: right pane
        push ax
        call file_extract  

        call main_highlight
        jmp main_loop


main_loop:      mov ah,00h      ;waiting for the user to press the key
                int 16h

                cmp al,1Bh        ; if it is escape, just exit
                je near exit

                cmp al,09h      ; if it is tab swictn panes
                je switch_panes

                cmp ah,48h      ; non extended keys like tab and escape are captured by AL else extended keys like
                je move_up      ; arrow keys are captured by AH
                      
                cmp ah,50h
                je move_down

                cmp al,0Dh
                je near enter_directory

                jmp main_loop   ;if any other key is pressed just wait again


switch_panes:   call main_unhighlight
                cmp byte [active_pane],0     
                je switch_to_right_pane

switch_to_left_pane:    mov ah,47h
                        mov dl,0
                        mov si,right_path+1
                        int 21h

                        mov byte [active_pane],0

                        mov ah,3Bh
                        mov dx,left_path
                        int 21h
                        jmp end_switch

switch_to_right_pane:   mov ah,47h      ; store the current directory in the buffer i gave
                        mov dl,0        ; 0 = Default Drive
                        mov si,left_path+1      ; +1 skips our hardcoded '\'
                        int 21h

                        mov byte [active_pane],1

                        mov ah,3Bh
                        mov dx,right_path       ; do not include the +1 as we are just reading the path
                        int 21h
                        jmp end_switch



end_switch:     jmp main_highlight

        

move_up:        call main_unhighlight
                mov al,[current_row]
                cmp al,2
                je first_row
                dec al
                mov [current_row],al
                jmp main_highlight

first_row:      mov al,21
                mov [current_row],al
                jmp main_highlight


move_down:      call main_unhighlight
                mov al,[current_row]
                cmp al,21       ;last row that can be accessed
                je last_row
                inc al
                mov [current_row],AL
                jmp main_highlight
                
last_row:       mov al,2 ; first accessible row
                mov [current_row],al
                jmp main_highlight



main_highlight: xor ax,ax
                mov al,[active_pane]
                push ax
                mov al,[current_row]
                push ax
                mov al,[l_start_cols]
                push ax
                mov al,[l_end_cols]
                push ax
                mov al,[r_start_cols]
                push ax
                mov al,[r_end_cols]
                push ax
                call highlight_row
                jmp main_loop



main_unhighlight:       push ax
                        xor ax,ax
                        mov al,[active_pane]
                        push ax
                        mov al,[current_row]
                        push ax
                        mov al,[l_start_cols]
                        push ax
                        mov al,[l_end_cols]
                        push ax
                        mov al,[r_start_cols]
                        push ax
                        mov al,[r_end_cols]
                        push ax
                        call unhighlight_row
                        pop ax
                        ret





exit:   
        mov ax,4c00h
        int 21h



%include "dirs.asm"
%include "init_ui.asm"
%include "helper.asm"
%include "help_ui.asm"
%include "logic.asm"
%include "extract.asm"
%include "view_ui.asm"
%include "data.asm"