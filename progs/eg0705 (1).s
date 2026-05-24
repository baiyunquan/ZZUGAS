	.arch armv8-a
	.file	"eg0705.c"
	.text
	.align	2
	.global	isletter
	.type	isletter, %function
isletter: /*入口参数W0=c*/
.LFB11:
	.cfi_startproc
	
    mov w1, 122  /*122是字符‘z’的ASCII码*/
    cmp w0, 97   /*与字符‘a’比较*/
    ccmp w0,w1,#0b0010,hs /*大于等于‘a’,则与字符'z'比较,否则使NZCV=0*/
    bhi	.L3         /*大于25，不是小写字母,转移*/
	mov	w0, 1       /*小于等于25，是小写字母*/
.L1:
	ret
.L3:
	mov	w0, -1
	b	.L1
	.cfi_endproc
.LFE11:
	.size	isletter, .-isletter
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"%d"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB12:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	mov	w0, '<'
	bl	isletter
	mov	w1, w0
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	printf
	mov	w0, 0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
