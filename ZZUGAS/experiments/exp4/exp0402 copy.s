.intel_syntax noprefix
.text
.globl main
.type  main, @function

main:
    mov eax, 36000
    mov ecx, eax
    sal eax, 4
    lea eax, [eax + ecx*4]
    add eax, ecx
    mov eax, 0xb8920

    

    ret
