assume cs:code

code segment
  start: mov ax, cs
         mov ds, ax
	 mov si, offset diskio
	 mov ax, 0
	 mov es, ax
	 mov di, 200h
	 mov cx, offset diskioend-offset diskio
	 cld
	 rep movsb

	 mov ax, 0
	 mov es, ax
	 mov word ptr es:[7ch*4], 200h
	 mov word ptr es:[7ch*4+2], 0

	 mov ax, 4c00h
	 int 21h

 diskio: push ax
         push bx
	 push cx
	 push dx

         cmp ah, 0
	 je diskread
	 cmp ah, 1
	 je diskwrite
	 jmp ok

diskread: push ax
          call getaddress
	  mov ah, 2
	  mov al, 1
	  int 13h

	  pop ax
	  jmp ok
          
diskwrite: push ax
          call getaddress
	  mov ah, 3
	  mov al, 1
	  int 13h

	  pop ax
	  jmp ok

getaddress: push bx
            push si
            mov si, 1440
            mov ax, dx
	    mov dx, 0
            div si

	    mov bx, dx
	    mov dh, al

	    mov ax, bx
	    mov bl, 18 
	    div bl 

	    mov ch, al
	    inc ah
	    mov cl, ah
	    mov dl, 0

	    pop si
	    pop bx
	    ret
      ok: pop dx
          pop cx
          pop bx
	  pop ax
          iret
diskioend: nop
code ends
end start
