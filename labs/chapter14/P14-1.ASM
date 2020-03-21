assume cs:code

code segment
  mov ax, 20
  mov bx, ax

  shl ax, 1
  mov cl, 3
  shl bx, cl
  add ax, bx
  
  mov ax, 4c00h
  int 21h
code ends
end
