assume cs:code

code segment
  a dw 1,2,3,4,5,6,7,8
  b dd 0

  start: mov si, 0
         mov cx, 8
      s: mov ax, a[si]
         add cs:[16], ax
	 adc word ptr cs:[18], 0
	 add si, 2
	 loop s
	 mov ax, 4c00h
	 int 21h
code ends
end start

