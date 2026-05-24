	.arch armv8-a
	.file	"eg0506.c"
	.text
	.align	2
	.global	caculator
	.type	caculator, %function
caculator: /*入口参数x1，x2，x3*/
.LFB11:
	.cfi_startproc
	and	w0, w0, 255
    sub w5, w0, '*'
    cmp w5,20
    bhi .L11
    
   
    ADRP X4, jump_table   // Load jump table base (high bits)
    ADD X4, X4, :lo12:jump_table  // Complete address
    LDR X6, [X4, X5, LSL #3] // X6 = jump_table[offset] (64-bit entries)
    
    br x6
	
    /*cmp	w0, 47
	beq	.L2
	cmp	w0, 47
	bhi	.L3
	cmp	w0, 43
	beq	.L4
	cmp	w0, 45
	bne	.L10*/
Lsub: sub	w2, w1, w2
	str	w2, [x3]
	mov	w0, 0
	b	.L1
.L10:
	//cmp	w0, 42
	//bne	.L11
	mul	w2, w2, w1
	str	w2, [x3]
	mov	w0, 0
	b	.L1
.L11:
	mov	w0, 1
.L1:
	ret
.L3:
	//cmp	w0, 60
	//beq	.L8
	//cmp	w0, 62
	//bne	.L12
	asr	w2, w2, 2
	str	w2, [x3]
	mov	w0, 0
	b	.L1
.L12:
	mov	w0, 1
	b	.L1
.L4:
	add	w2, w2, w1
	str	w2, [x3]
	mov	w0, 0
	b	.L1
.L2:
	sdiv	w2, w1, w2
	str	w2, [x3]
	mov	w0, 0
	b	.L1
.L8:
	lsl	w2, w1, 1
	str	w2, [x3]
	mov	w0, 0
	b	.L1
	.cfi_endproc
.LFE11:
	.size	caculator, .-caculator
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
jump_table:
    .quad .L10 /* '*'=42 */
    .quad .L4 /* '+'=43 */
    .xword .L11 /* default */
    .xword  Lsub /* Lsub 是自定义的标号，'-'=45*/
    .xword .L11 /* default */
    .xword .L2 /* '/'=47 */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L11 /* default */
    .xword .L8 /* '<'=60 */
    .xword .L3 /* '>'=62 */
    
    .align 3
.LC0:
	.string	"%c"
	.align	3
.LC1:
	.string	"%d"
	.align	3
.LC2:
	.string	"input error"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB12:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	add	x1, sp, 31
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	__isoc99_scanf
	add	x3, sp, 24
	mov	w2, -300
	mov	w1, 200
	ldrb	w0, [sp, 31]
	bl	caculator
	cbnz	w0, .L14
	ldr	w1, [sp, 24]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	printf
.L15:
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	.cfi_remember_state
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
.L14:
	.cfi_restore_state
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
	b	.L15
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
