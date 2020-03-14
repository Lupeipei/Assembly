assume cs:code

code segment
  start: mov al, 100
         mov bl, 10
	 mul bl

	 mov ax, 100
	 mov bx, 10000
	 mul bx

	 mov ax, 4c00h
	 int 21h
code ends
end start
