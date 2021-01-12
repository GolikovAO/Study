.model tiny
.186
.code
org 100h
start:
mov ah,02h
mov dl,41h
int 21h
int 20h
end start
