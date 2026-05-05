
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

file_list:

    ; --- ROW 2 ---
    db "MAIN.ASM", 0, 0, 0, 0, 0 ; Name (13 bytes)
    db 00h                       ; Attribute (File)
    dd 2048                      ; Size
    dw 5CA5h                     ; Date: May 5, 2026
    dw 73C0h                     ; Time: 14:30:00
    times 10 db 0                ; Padding to hit 32 bytes

    ; --- ROW 3 ---
    db "UI_HELP.ASM", 0, 0       ; Name
    db 00h                       ; Attribute (File)
    dd 1420                      ; Size
    dw 5C21h                     ; Date: Jan 1, 2026
    dw 49E5h                     ; Time: 09:15:10
    times 10 db 0

    ; --- ROW 4 ---
    db "LOGIC.ASM", 0, 0, 0, 0   ; Name
    db 00h                       ; Attribute (File)
    dd 3050                      ; Size
    dw 5C8Ah                     ; Date: Apr 10, 2026
    dw 5A00h                     ; Time: 11:16:00
    times 10 db 0

    ; --- ROW 5 ---
    db "DATA.ASM", 0, 0, 0, 0, 0 ; Name
    db 00h                       ; Attribute (File)
    dd 850                       ; Size
    dw 5CA4h                     ; Date: May 4, 2026
    dw 846Ah                     ; Time: 16:35:20
    times 10 db 0

    ; --- ROW 6 ---
    db "PROJECTS", 0, 0, 0, 0, 0 ; Name
    db 10h                       ; Attribute (DIRECTORY!)
    dd 0                         ; Size (Dirs show 0)
    dw 5A42h                     ; Date: Feb 2, 2025
    dw 6000h                     ; Time: 12:00:00
    times 10 db 0

    ; --- ROW 7 ---
    db "NORTON.EXE", 0, 0, 0     ; Name
    db 00h                       ; Attribute (File)
    dd 15360                     ; Size
    dw 2021h                     ; Date: Jan 1, 1996
    dw 0000h                     ; Time: 00:00:00
    times 10 db 0

    ; --- ROW 8 ---
    db "README.TXT", 0, 0, 0     ; Name
    db 00h                       ; Attribute (File)
    dd 512                       ; Size
    dw 5CA5h                     ; Date: May 5, 2026
    dw 4100h                     ; Time: 08:08:00
    times 10 db 0

    ; --- ROW 9 ---
    db "INCLUDES", 0, 0, 0, 0, 0 ; Name
    db 10h                       ; Attribute (DIRECTORY!)
    dd 0                         ; Size
    dw 5B5Fh                     ; Date: Oct 31, 2025
    dw 7A00h                     ; Time: 15:16:00
    times 10 db 0

    ; --- ROW 10 ---
    db "BUILD.BAT", 0, 0, 0, 0   ; Name
    db 00h                       ; Attribute (File)
    dd 128                       ; Size
    dw 5CA5h                     ; Date: May 5, 2026
    dw 7E1Dh                     ; Time: 15:48:58
    times 10 db 0

    ; --- ROW 11 ---
    db "TODO.LST", 0, 0, 0, 0, 0 ; Name
    db 00h                       ; Attribute (File)
    dd 94                        ; Size
    dw 5CA0h                     ; Date: May 0, 2026
    dw 4800h                     ; Time: 09:00:00
    times 10 db 0

    ; --- ROW 12 ---
    db "SYSTEM", 0, 0, 0, 0, 0, 0 ; Name
    db 10h                       ; Attribute (DIRECTORY!)
    dd 0                         ; Size
    dw 5A21h                     ; Date: Jan 1, 2025
    dw 0000h                     ; Time: 00:00:00
    times 10 db 0

    ; --- ROW 13 ---
    db "CONFIG.SYS", 0, 0, 0     ; Name
    db 00h                       ; Attribute (File)
    dd 256                       ; Size
    dw 5021h                     ; Date: Jan 1, 2020
    dw 0000h                     ; Time: 00:00:00
    times 10 db 0

    ; --- ROW 14 ---
    db "AUTOEXEC.BAT", 0         ; Name (Exactly 12 chars + 1 null)
    db 00h                       ; Attribute (File)
    dd 312                       ; Size
    dw 5021h                     ; Date: Jan 1, 2020
    dw 0000h                     ; Time: 00:00:00
    times 10 db 0

    ; --- ROW 15 ---
    db "DEBUG.EXE", 0, 0, 0, 0   ; Name
    db 00h                       ; Attribute (File)
    dd 24576                     ; Size
    dw 4A21h                     ; Date: Jan 1, 2017
    dw 6000h                     ; Time: 12:00:00
    times 10 db 0

    ; --- ROW 16 ---
    db "MEM.EXE", 0, 0, 0, 0, 0, 0 ; Name
    db 00h                       ; Attribute (File)
    dd 12400                     ; Size
    dw 4A21h                     ; Date: Jan 1, 2017
    dw 6000h                     ; Time: 12:00:00
    times 10 db 0

    ; --- ROW 17 ---
    db "DOCS", 0, 0, 0, 0, 0, 0, 0, 0 ; Name
    db 10h                       ; Attribute (DIRECTORY!)
    dd 0                         ; Size
    dw 5C2Ah                     ; Date: Jan 10, 2026
    dw 4800h                     ; Time: 09:00:00
    times 10 db 0

    ; --- ROW 18 ---
    db "MANUAL.PDF", 0, 0, 0     ; Name
    db 00h                       ; Attribute (File)
    dd 1048576                   ; Size (1 Megabyte!)
    dw 5C2Ch                     ; Date: Jan 12, 2026
    dw 5000h                     ; Time: 10:00:00
    times 10 db 0

    ; --- ROW 19 ---
    db "GRAPHICS", 0, 0, 0, 0, 0 ; Name
    db 10h                       ; Attribute (DIRECTORY!)
    dd 0                         ; Size
    dw 5C45h                     ; Date: Feb 5, 2026
    dw 6000h                     ; Time: 12:00:00
    times 10 db 0

    ; --- ROW 20 ---
    db "LOGO.BMP", 0, 0, 0, 0, 0 ; Name
    db 00h                       ; Attribute (File)
    dd 65536                     ; Size
    dw 5C4Ah                     ; Date: Feb 10, 2026
    dw 7000h                     ; Time: 14:00:00
    times 10 db 0

    ; --- ROW 21 ---
    db "TEST.BIN", 0, 0, 0, 0, 0 ; Name
    db 00h                       ; Attribute (File)
    dd 50                        ; Size
    dw 5CA5h                     ; Date: May 5, 2026
    dw 7C00h                     ; Time: 15:32:00
    times 10 db 0

    ; --- END OF ARRAY MARKER ---
    ; Your loop MUST check for 0FFh in the very first byte to know it hit the end!
    db 0FFh                      ; End Marker
    times 31 db 0                ; Pad the rest of the 32 bytes so it doesn't break alignment

