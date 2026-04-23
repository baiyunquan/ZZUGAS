.section .data

.section .text
.globl main
.type  main, @function


main:
    xorl %eax, %eax
	xorl %ebx, %ebx
	movl $92681, %ecx

Sum:
	incl %ebx
	addl %ebx, %eax
	loop Sum
	
Done:
	call dispuid
    call dispcrlf
	movl $92681, %eax
    call dispuid
    call dispcrlf

	xorl %eax, %eax
	ret
