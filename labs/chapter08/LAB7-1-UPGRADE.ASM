assume cs:codesg, es:table, ss:stacksg

data segment
db '1975','1976','1977','1978','1979','1980','1981','1982' 
db '1983','1984','1985','1986','1987','1988','1989','1990'
db '1991','1992','1993','1994','1995'
;stands for years from 1975 to 1995

dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
;stands for yearly revenue from 1975 to 1995

dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
dw 11542,14430,15257,17800
;stands for number of employees from 1975 to 1995

data ends

table segment
  db 21 dup ('year summ ne ?? ')
table ends

stacksg segment
  dw 8 dup (0)
stacksg ends

codesg segment
  start: mov ax, data
         mov ds, ax
	 mov bx, 0
	 mov bp, 0
	 mov di, 0

	 mov ax, table
	 mov es, ax

	 mov ax, stacksg
	 mov ss, ax
	 mov sp,0
	 
	 mov cx, 21
      s: push cx 
         mov si, 0
	 mov cx, 2
     s0: mov ax, ds:[bp+si] 
         mov es:[bx+si], ax

	 mov ax, ds:[bp+21*4+si]
	 mov es:[bx+5+si], ax

	 add si,2
	 loop s0


         mov ax, ds:[di+21*4+21*4]
	 mov es:[bx+10], ax

         mov ax, es:[bx+5]
         mov dx, es:[bx+7]
	 div word ptr es:[bx+10]
	 mov es:[bx+13], ax

	 pop cx
	 add bx, 16
	 add bp, 4
	 add di, 2
	 loop s

	 mov ax, 4c00h
	 int 21h
codesg ends
end start
