/* eg0407.s in Linux Terminal for GCC_64*/
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
        add eax,[r9+rbx]#低位双字相加，eax=0x946901ee,EFLAGS=0x00000286
        
        mov [r10+rbx],eax
        
        inc rbx
        mov eax,[r8+rbx*4]
        adc eax,[r9+rbx*4]
        #高位双字相加，再加CF，eax=0xceee5000,EFLAGS=00000A86
        
        mov [r10+rbx*4],eax
          
        mov rax,dvar3[rip]
        call disphx
        
        #返回值
       xor eax,eax        #返回0
       ret