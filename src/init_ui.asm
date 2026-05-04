initialize_ui:  call blue_background
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


                ret
