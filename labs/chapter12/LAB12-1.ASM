assume cs:code

code segment
 start: mov ax, cs
        mov ds, ax
	mov si, offset do0

	mov ax, 0
	mov es, ax
	mov di, 200h

	; copy do0 to 0000:0200h
	mov cx, offset do0end-offset do0
	cld
	rep movsb

	; set do0 entry point in tables
	mov ax, 0
	mov es, ax
	mov word ptr es:[0*4], 200h
	mov word ptr es:[0*4+2], 0
	
	mov ax, 4c00h
	int 21h
   do0: jmp short do0start
        db 'divide error!'
do0start: mov ax, cs
          mov ds, ax
	  mov si, 202h

	  mov ax, 0b800h
	  mov es, ax
	  mov di, 12*160+36*2

	  mov cx, 13
       s: mov al, ds:[si]
          mov es:[di], al
	  inc si
	  add di, 2
	  loop s
	  
	  mov ax, 4c00h
	  int 21h
do0end: nop
code ends
end start
