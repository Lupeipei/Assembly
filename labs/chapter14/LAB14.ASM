assume cs:code

code segment
  s: db 16 dup(0)
  a: db 9,8,7,4,2,0

  start: mov ax, cs
         mov ds, ax
	 mov di, offset s
	 mov si, offset a

	 mov cx, 6

     s0: push cx
         mov al, ds:[si]
         out 70h, al
	 in al, 71h

	 mov ah,al
	 mov cl,4
	 shr ah, cl
	 and al, 00001111b

	 add ah, 30h
	 add al, 30h

	 mov ds:[di], ah
	 mov ds:[di+1], al

	 inc si
	 add di, 2 
	 pop cx
	 loop s0
	 
	; set color as green
	 mov bx, 0b800h
	 mov es, bx
	 mov cx, 40
	 mov bp, 160*12
     s1: mov byte ptr es:[bp+1], 2
     	 add bp, 2
	 loop s1

        ; display yy/mm/dd hh:mm:ss, cool!!
	 mov bx, offset s
	 mov bp, 160*12
	 mov si, 0

     s2: cmp si, 2
	 jna slash
	 cmp si, 4
	 jna empty
	 cmp si, 8
	 jna semi 
	 cmp si, 10
	 jnb ok

  slash: mov al, ds:[bx + si]
	 mov byte ptr es:[bp], al
         mov al, ds:[bx + si + 1]
	 mov byte ptr es:[bp + 2], al
	 mov byte ptr es:[bp + 4],'/'

	 add si, 2
	 add bp, 6
	 jmp short s2
		
  empty: mov al, ds:[bx + si]
	 mov byte ptr es:[bp], al
         mov al, ds:[bx + si + 1]
	 mov byte ptr es:[bp + 2], al
	 mov byte ptr es:[bp + 4],' '

	 add si, 2
	 add bp, 6
	 jmp short s2

   semi: mov al, ds:[bx + si]
	 mov byte ptr es:[bp], al
         mov al, ds:[bx + si + 1]
	 mov byte ptr es:[bp + 2], al
	 mov byte ptr es:[bp + 4],':'

	 add si, 2
	 add bp, 6
	 jmp short s2

   ok: mov al, ds:[bx + si]
       mov byte ptr es:[bp], al
       mov al, ds:[bx + si + 1]
       mov byte ptr es:[bp + 2], al
       mov ax, 4c00h
       int 21h
code ends
end start
