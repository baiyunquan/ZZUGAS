# eg0529.s
.intel_syntax noprefix
.text
.global main
main:
 sub	rsp, 32 
 mov al, 0x80
 sub al, 1
 call dprf
 
 mov al, 0xff
 add al, 0xff
 call dprf
 
 add rsp, 32
 mov eax, 0
 ret
 
 .include "./progs/eg0529s.s"
 