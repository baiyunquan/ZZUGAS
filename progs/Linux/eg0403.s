#eg0403.s in Linux Console
# assembly]# ./nmake32.sh ./progs/eg0403 


        .intel_syntax noprefix
        
        .section .data
        
        .section .text
        .globl main
        main:
        pushf
        pop rax
        call disphx
        #返回值
       xor eax,eax        #返回0
       ret
       