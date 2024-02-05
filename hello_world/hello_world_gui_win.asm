; format MZ
; entry .code:start

; segment .code
; start:
;     mov ax, .data
;     mov ds, ax
;     mov dx, msg
;     mov ah, 9
;     int 21h
;     mov ah, 4ch
;     int 21h

; segment .data

;     msg db 'Hello World', '$'






; format MZ

; entry main:start                        ; program entry point
; stack 100h                              ; stack size

; segment main                            ; main program segment

;   start:
;         mov     ax,text
;         mov     ds,ax

;         mov     dx,hello
;         call    extra:write_text

;         mov     ax,4C00h
;         int     21h

; segment text

;   hello db 'Hello world!',24h

; segment extra

;   write_text:
;         mov     ah,9
;         int     21h
;         retf       
    






include "win64ax.inc"

.data
Caption db 'Win64 assembly',0
Message db 'URMOM BIG!',0

.code
start:
    xor r9d,r9d
    lea r8,[Caption]
    lea rdx,[Message]
    xor rcx,rcx
    call [MessageBox]
    mov ecx,eax
    invoke ExitProcess,0

.end start   
