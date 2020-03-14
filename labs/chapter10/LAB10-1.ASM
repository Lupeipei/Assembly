assume cs:code, ds:data

data segment
  db 'welcome to masm!', 0
data ends

code segment
  start: mov dh, 8
         mov dl, 3
	 mov cl, 2
	 mov ax, data
	 mov ds, ax
	 mov si, 0
	 call show_str

	 mov ax, 4c00h
	 int 21h
show_str: mov ax, 0b800h
          mov es, ax
	  
	  mov bl, cl
	  mov cl, 0

	  mov al, 160
	  mul dh
	  mov bp, ax

	  mov al, 2
	  dec dl
	  mul dl
	  mov di, ax
	  add bp, di
	  mov di, 0

 display: mov ch, ds:[si]
	  jcxz finish
	  mov es:[bp + di], ch
	  mov es:[bp + di + 1], bl
	  inc si
	  add di, 2
	  jmp short display
  finish: ret
code ends
end start
