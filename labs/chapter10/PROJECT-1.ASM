assume cs:codesg, ds:data, ss:stacksg

; 所要显示的原始数据

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

db 10 dup(0)
; 用于暂存十进制数值
data ends

stacksg segment
  dw 16 dup (0)
stacksg ends

codesg segment
  start: mov ax, data
         mov ds, ax

      	 mov ax, stacksg
      	 mov ss, ax
      	 mov sp, 20h

         mov ax, 0b800h
         mov es, ax

      	; 初始化用于定位的寄存器, bp 为160，从第一行开始
      	 mov bx, 0
      	 mov bp, 160
      	 mov si, 0

         ; 默认在屏幕的1行0列开始显示，cx用于循环，故改用dl保存色值，颜色为绿色
      	 mov dh, 0
      	 mov dl, 2

      	 ; 按行显示，循环21次, cx = 21 
      	 mov cx, 21
      s: push cx 
      	 mov di, 0
      	 call display_years
      	 call display_revenue
      	 call display_employees
      	 call display_per_income
      	 add bp, 160
      	 add si, 4 
      	 add bx, 2
      	 pop cx
      	 loop s

      	 mov ax, 4c00h
      	 int 21h

; 显示年份
display_years: push dx
               push si
               mov cx, 4
    show_year: mov dh, ds:[si]
      	       mov es:[bp + di], dh
      	       mov es:[bp + di + 1], dl
      	       add di, 2
      	       inc si
      	       loop show_year

	       ; 在年份后的空白处显示空字符
  show_empty0: mov byte ptr es:[bp+di], ' '
      	       mov es:[bp + di + 1], dl
      	       add di, 2
          		 cmp di, 40
          		 jna show_empty0

      	       pop si
      	       pop dx
    end_years: ret

; 显示年收入
display_revenue: push ax
                 push dx
            		 push cx
            		 mov ax, ds:[21*4+si] ; 年收入是两个字，高位存在dx中，低位存在ax
            		 mov dx, ds:[21*4+si+2]
            		 mov cx, 10
            		 call dtoc  ; 使用实验10的小程序3显示十进制的字符串
            		 pop cx
            		 pop dx
            		 pop ax

            		 call show_str ; 使用实验10的小程序1显示十进制的字符串

	        ; 在年收入后的空白处显示空字符
   show_empty1: mov byte ptr es:[bp+di], ' '
      	        mov es:[bp + di + 1], dl
      	        add di, 2
            		cmp di, 80
            		jna show_empty1
   end_revenue: ret


; 显示员工数量
display_employees: push ax
                   push dx
              		 push cx
              		 mov ax, ds:[21*8+bx]
              		 mov dx, 0 
              		 mov cx, 10
              		 call dtoc  ; 使用实验10的小程序3显示十进制的字符串
              		 pop cx
              		 pop dx
              		 pop ax

              		 call show_str ; 使用实验10的小程序1显示十进制的字符串

	        ; 在员工数量后的空白处显示空字符
    show_empty2: mov byte ptr es:[bp+di], ' '
      	        mov es:[bp + di + 1], dl
      	        add di, 2
            		cmp di, 120 
            		jna show_empty2
  end_employees: ret

; 显示年均人收入
display_per_income: push ax
                    push dx
                		push cx
                		mov ax, ds:[21*4+si]
                		mov dx, ds:[21*4+si + 2]
                		mov cx, ds:[21*8+bx]
                		call divdw ; 使用实验10的小程序2先得出人均年收入，高位存放在dx, 低位存放在ax
                		mov cx, 10
                		call dtoc  ; 使用实验10的小程序3显示十进制的字符串
                		pop cx
                		pop dx
                		pop ax

                		call show_str ; 使用实验10的小程序1显示十进制的字符串

	        ; 在年均人收入后的空白处显示空字符
    show_empty3: mov byte ptr es:[bp+di], ' '
        	       mov es:[bp + di + 1], dl
        	       add di, 2
            		 cmp di, 160 
            		 jna show_empty3
end_per_income: ret

   dtoc: push si
      	 push di
      	 push bp 

      	 mov si, 0
      	 mov di, 0
      	 mov bp, cx

     s0: mov cx, bp 
         call divdw

      	 add cx, 30h
      	 push cx
      	 inc si ; si 用来记录总的十进制数的字符串个数, 出栈时用到
      	 mov cx, ax
      	 jcxz s1
      	 jmp short s0

     s1: pop ax
         mov ds:[21*10 + di], al
      	 dec si
      	 mov cx, si
      	 jcxz ok
      	 inc di
      	 jmp short s1

     ok: pop bp
         pop di
         pop si
         ret 

   divdw: push bx
          push ax
          mov ax, dx
      	  mov dx, 0
      	  div cx
      	  mov bx, ax

      	  pop ax
      	  div cx

      	  mov cx, dx
      	  mov dx, bx
      	  pop bx
          ret

 show_str: push cx
           push si
      	   mov si, 0
           mov ch, 0
 display: mov cl, ds:[21*10 + si]
      	  jcxz finish
      	  mov es:[bp + di], cl
      	  mov es:[bp + di + 1], dl
       	  mov ds:[21*10+si], ch
      	  inc si
      	  add di, 2
      	  jmp short display
  finish: pop si 
          pop cx
          ret

codesg ends
end start
