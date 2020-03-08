assume cs:codesg, ds:datasg

datasg segment
  dd 12345678h
datasg ends

codesg segment
  start: mov ax, datasg
         mov ds, ax
	 mov bx, 0
	 mov [bx], word ptr 0
	 mov [bx+2], cs
	 jmp dword ptr ds:[0]

	 mov ax, 4c00h
	 int 21h
codesg ends
end start
