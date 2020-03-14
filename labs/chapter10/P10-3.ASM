assume cs:code

stack segment
  db 16 dup (0)
stack ends

code segment
start: mov ax, stack
       mov ss, ax
       mov sp, 16
       mov ax, 1000h
       push ax
       mov ax, 0
       push ax
       retf
       mov ax, 4c00h
       int 21h
code ends

end start
