assume cs:code, ds:data, ss:stack

data segment
 db 10 dup (0)
data ends

stack segment
 dw 16 dup(0)
stack ends

code segment
  start: mov ax, data
         mov ds, ax
	 mov si, 0

	 mov ax, stack
	 mov ss, ax
	 mov sp, 10h

         mov ax, 12666
	 call dtoc

	 mov dh, 8
	 mov dl, 3
	 mov cl, 2
	 call show_str

	 mov ax, 4c00h
	 int 21h

   dtoc: push ax
         push bx
	 push cx
	 push si
	 push di

	 mov si, 0
	 mov di, 0
	 mov bx, 10

     s0: mov dx, 0
	 div bx

	 add dx, 30h
	 push dx
	 inc si ; si 用来记录总的字符串个数
	 mov cx, ax
	 jcxz s1
	 jmp short s0

     s1: pop ax
         mov ds:[di], al
	 dec si
	 mov cx, si
	 jcxz ok
	 inc di
	 jmp short s1

     ok: pop di
         pop si
         pop cx
	 pop bx
	 pop ax
         ret 

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
	  mov si, 0

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
