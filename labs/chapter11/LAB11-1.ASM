assume cs:codesg, ds: datasg

datasg segment
  db "Beginner's All-purpose Symbolic Instruction Code.", 0
datasg ends

codesg segment
  begin: mov ax, datasg
         mov ds, ax
	 mov si, 0

	 call letterc
	 call show_str

	 mov ax, 4c00h
	 int 21h
letterc: mov cl, ds:[si]
         mov ch, 0
	 jcxz back
         cmp cl, 97 ; lowercase a~z's ASCII code is 97~122
	 jb next
	 cmp cl, 122
	 ja next
	 and cl, 11011111b
	 mov ds:[si], cl
   next: inc si
         jmp short letterc
   back: ret

show_str: mov ax, 0b800h
          mov es, ax
	  mov cl, 0
	  
	  mov si, 0
	  mov di, 12*160 + 30

 display: mov ch, ds:[si]
	  jcxz finish
	  mov es:[di], ch
	  mov byte ptr es:[di + 1], 2
	  inc si
	  add di, 2
	  jmp short display
  finish: ret
codesg ends
end begin
