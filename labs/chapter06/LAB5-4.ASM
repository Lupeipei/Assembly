assume cs:code
a segment
  db 1,2,3,4,5,6,7,8
a ends

b segment
  db 1,2,3,4,5,6,7,8
b ends

c segment
  db 0,0,0,0,0,0,0,0
c ends

code segment
start: mov ax, a
       mov ds, ax

       mov ax, b
       mov es, ax

       mov ax, c
       mov ss, ax
       mov sp, 16

       mov bx, 0
       mov cx, 8
       mov ax, 0
    s: add ax, ds:[bx]
      add ax, es:[bx]
      push ax
      mov ax, 0
      inc bx
      loop s
      mov ax, 4c00h
      int 21h
code ends

end start
