	.file	"eg0504b.c"
	.intel_syntax noprefix
	.text
	.globl	sub_of
	.type	sub_of, @function
sub_of:
.LFB11:
	.cfi_startproc
	sub	edi, esi
	mov	DWORD PTR [rdx], edi
    #########################
      jno L1
      mov eax,1
      jmp L2
    #########################

	L1: mov	eax, 0
	L2: ret
	.cfi_endproc
.LFE11:
	.size	sub_of, .-sub_of
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"x-y = %d = %u = %x"
.LC1:
	.string	"\346\272\242\345\207\272"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	sub	rsp, 24
	.cfi_def_cfa_offset 32
	lea	rdx, [rsp+12]
	mov	esi, -999999999
	mov	edi, 1234567890
	call	sub_of
	test	eax, eax
	jne	.L3
	mov	esi, DWORD PTR [rsp+12]
	mov	ecx, esi
	mov	edx, esi
	mov	edi, OFFSET FLAT:.LC0
	call	printf
.L4:
	mov	eax, 0
	add	rsp, 24
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L3:
	.cfi_restore_state
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
	jmp	.L4
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
