/* eg0410.s  for GCC_64*/
        .intel_syntax noprefix
        
        .section .data
        dvar1: .long 0x82347856,0x67783000
        dvar2: .long 0x12348998,0x67762000
        dvar3: .quad 0

        .section .text
        .globl main
        main:
        mov rbx,0
        
        lea r8,dvar1[rip]
        lea r9,dvar2[rip]
        lea r10,dvar3[rip]
               
        mov eax,[r8+rbx]
        sub eax,[r9+rbx]#低位双字相减，eax=0x6fffeebe,EFLAGS=0x00000A16
        mov [r10+rbx],eax
              
        mov eax,[r8+rbx+4]
        sbb eax,[r9+rbx+4]
        #高位双字相减，再减CF，eax=0x00021000,EFLAGS=0x00000206
        mov [r10+rbx+4],eax
        
                 
        mov rax,dvar3[rip]
        call disphx
        call dispcrlf
        
        #返回值
       xor eax,eax        #返回0
       ret