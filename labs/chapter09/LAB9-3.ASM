assume cs:code, ds:data

data segment
  db 'welcome to masm!'
data ends

code segment
  start: mov ax, data
         mov ds, ax

         mov ax, 0b800h 
         mov es, ax

	 mov dl, 01110001b ; blue with write background
	 mov bx, 780h

	 mov cx, 16 
	 mov si, 0
	 mov di, 0
	 
      s: mov al, ds:[di]
	 mov es:[bx + 64 + si], al
	 mov es:[bx + 65 + si], dl 
	 add si, 2
	 inc di
	 loop s

	 mov ax, 4c00h
	 int 21h
code ends
end start
