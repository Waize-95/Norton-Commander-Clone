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











fix_boundry:    mov ax,0xb800
                mov es,ax
                mov ax,1BC1h
                mov di,3560
                mov [es:di],ax
                add di,20
                mov [es:di],ax
                mov ax,1BBAh
                add di,18  
                mov [es:di],ax
                add di,2
                mov [es:di],ax
                mov ax,1BC1h
                add di,40
                mov [es:di],ax
                add di,20
                mov [es:di],ax


;=================================================================================================================
; the above was just initialization of the whole UI


; the whole main starting logic after initialization of the UI starts here

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

                jmp main_loop   ;if any other key is pressed just wait again


;IDEA instead of just copying and pasting unhighlight everywhere, i can send a value in al like 0,1,2
; after calling the unhighligh_row i compare the value of al, if it is 0 i jump to switch panes etc
  
; or even better idea is that we can use wrapper subroutine, we can create another subroutine called
; main_unhighlight and just call it from anywhere, whenever it is returned it will be returned to exactly
; next line from where it was originally called

switch_panes:   xor ax,ax
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
                xor byte [active_pane],1
                jmp main_highlight

move_up:        xor ax,ax
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
                mov al,[current_row]
                cmp al,2
                je first_row
                dec al
                mov [current_row],al
                jmp main_highlight

first_row:      mov al,21
                mov [current_row],al
                jmp main_highlight


move_down:      xor ax,ax
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
                mov al,[current_row]
                cmp al,21       ;last row that can be accessed
                je last_row
                inc al
                mov [current_row],AL
                jmp main_highlight

last_row:       mov al,2 ; first accessible row
                mov [current_row],al
                jmp main_highlight






















exit:   
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


;===============================================================================================================

active_pane: db 0
current_row: db 2
l_start_cols: db 1
l_end_cols: db 38
r_start_cols: db 41
r_end_cols: db 78

