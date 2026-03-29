	.arch armv8-a
	.file	"eg0708.c"
	.text
	.align	2
	.global	sum_for
	.type	sum_for, %function
sum_for:
.LFB11:
	.cfi_startproc
	mov	w2, w0
	mov	w1, 1
	mov	w0, 0
	b	.L2
.L3:
	add	w0, w0, w1
	add	w1, w1, 1
.L2:
	cmp	w1, w2
	ble	.L3
	ret
	.cfi_endproc
.LFE11:
	.size	sum_for, .-sum_for
	.align	2
	.global	sum_while
	.type	sum_while, %function
sum_while:
.LFB12:
	.cfi_startproc
	mov	w2, w0
	mov	w0, 0
	mov	w1, 1
	b	.L5
.L6:
	add	w0, w0, w1
	add	w1, w1, 1
.L5:
	cmp	w1, w2
	ble	.L6
	ret
	.cfi_endproc
.LFE12:
	.size	sum_while, .-sum_while
	.align	2
	.global	sum_until
	.type	sum_until, %function
sum_until:
.LFB13:
	.cfi_startproc
	mov	w2, w0
	mov	w0, 0
	mov	w1, 1
.L8:
	add	w0, w0, w1
	add	w1, w1, 1
	cmp	w1, w2
	ble	.L8
	ret
	.cfi_endproc
.LFE13:
	.size	sum_until, .-sum_until
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"%d"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB14:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	str	x19, [sp, 16]
	.cfi_offset 19, -16
	mov	w0, 100
	bl	sum_for
	adrp	x19, .LC0
	add	x19, x19, :lo12:.LC0
	mov	w1, w0
	mov	x0, x19
	bl	printf
	mov	w0, 100
	bl	sum_while
	mov	w1, w0
	mov	x0, x19
	bl	printf
	mov	w0, 100
	bl	sum_until
	mov	w1, w0
	mov	x0, x19
	bl	printf
	mov	w0, 0
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE14:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
