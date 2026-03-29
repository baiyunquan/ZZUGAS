	.arch armv8-a
	.file	"eg0705.c"
	.text
	.align	2
	.global	isletter
	.type	isletter, %function
isletter:
.LFB11:
	.cfi_startproc
	/*and	w0, w0, 255
	sub	w0, w0, #97
	and	w0, w0, 255
	cmp	w0, 25*/
    
   //and	w0, w0, 255
    mov w1, 122  /*122是字符‘z’的ASCII码*/
  //  and	w1, w1, 255
    cmp w0, 97   /*与字符‘a’比较*/
    ccmp w0,w1,#0b0010,hs /*大于等于‘a’,则与字符'z'比较,否则使C=1*/
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
	mov	w0, 'A'
	bl	isletter
	cmp	w0, 1
	beq	.L8
	mov	w0, 78
	bl	putchar
.L6:
	mov	w0, 0
	ldp	x29, x30, [sp], 16
	.cfi_remember_state
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
.L8:
	.cfi_restore_state
	mov	w0, 89
	bl	putchar
	b	.L6
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
