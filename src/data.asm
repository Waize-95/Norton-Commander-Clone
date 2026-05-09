
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


;===============================================================================================================


; -------------------------------------------------------------------
; 32-BYTE MOCK FILE SYSTEM DATA
; [0-12]  : Filename string (13 bytes max, null terminated)
; [13]    : Attribute (00h = Normal File, 10h = Directory)
; [14-17] : File Size (DWORD - 4 bytes)
; [18-19] : MS-DOS Date Word (Bits: YYYYYYY MMMMDDDDD)
; [20-21] : MS-DOS Time Word (Bits: HHHHHMMMMMMSSSSS)
; [22-31] : Reserved Padding (10 bytes)
; -------------------------------------------------------------------


search_string db "*.*",0
dta_buffer  times 43 db 0
file_list:

    times 640 db 0
    ; --- END OF ARRAY MARKER ---
    db 0FFh                      ; End Marker


;Bytes 0 to 20 (21 bytes): Secret DOS search data. Ignore this completely.

;Byte 21 (1 byte): The File Attribute (e.g., 10h means Directory, 00h means Normal File).

;Bytes 22 to 23 (2 bytes): The File Time.

;Bytes 24 to 25 (2 bytes): The File Date.

;Bytes 26 to 29 (4 bytes): The File Size. (The lower 16-bits are at Byte 26, the upper 16-bits are at Byte 28).

;Bytes 30 to 42 (13 bytes): The File Name as a null-terminated string.
