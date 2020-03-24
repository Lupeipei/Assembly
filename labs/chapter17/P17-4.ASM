assume cs:code

code segment
  start: mov ax, 0
         mov es, ax
	 mov bx, 200h

	 mov al, 1
	 mov ch, 0
	 mov cl, 1
	 mov dl, 0
	 mov dh, 0

	 mov ah, 3
	 int 13h

	 mov ax, 4c00h
	 int 21h
code ends
end start
