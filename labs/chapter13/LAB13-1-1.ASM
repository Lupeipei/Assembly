assume cs:code

code segment
  start: mov ax, cs
         mov ds, ax
	 mov si, offset print
	 mov ax, 0
	 mov es, ax
	 mov di, 200h
	 mov cx, offset printend-offset print
	 cld
	 rep movsb

	 mov ax, 0
	 mov es, ax
	 mov word ptr es:[7ch*4], 200h
	 mov word ptr es:[7ch*4+2], 0

	 mov ax, 4c00h
	 int 21h

  print: push ax
         push es
	 push di
         mov ax, 0b800h
         mov es, ax
	 mov ah, 0
	 mov al, 160
	 mul dh
	 mov di, ax

	 add dl, dl
	 sub dl, 2
	 mov dh, 0
	 add di, dx

      s: mov al, ds:[si]
	 cmp al, 0
	 je ok
	 mov es:[di], al
	 mov es:[di+1], cl
	 inc si
	 add di, 2
	 jmp short s
      ok: pop di
	  pop es
	  pop ax
	  iret
printend: nop
code ends
end start
