	.file	"exp0204.c"
	.intel_syntax noprefix
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	sub	rsp, 392
	.cfi_def_cfa_offset 400
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR [rsp+376], rax
	xor	eax, eax
	movabs	rax, 3539882223192780849
	mov	QWORD PTR [rsp+288], rax
	movabs	rax, 3828116996166267424
	mov	QWORD PTR [rsp+296], rax
	movabs	rax, 4116351770431600160
	mov	QWORD PTR [rsp+304], rax
	movabs	rax, 4908997399661265184
	mov	QWORD PTR [rsp+312], rax
	mov	DWORD PTR [rsp+320], 1176519968
	mov	BYTE PTR [rsp+324], 0
	movabs	rax, 3255307721844469037
	mov	QWORD PTR [rsp+336], rax
	movabs	rax, 3255307777713450285
	mov	QWORD PTR [rsp+344], rax
	mov	QWORD PTR [rsp+352], rax
	mov	QWORD PTR [rsp+360], rax
	mov	DWORD PTR [rsp+368], 757935405
	mov	WORD PTR [rsp+372], 45
	movabs	rax, 2315167007338672178
	mov	QWORD PTR [rsp+48], rax
	movabs	rax, 2316292922882072610
	mov	QWORD PTR [rsp+56], rax
	movabs	rax, 2317418839969046566
	mov	QWORD PTR [rsp+64], rax
	movabs	rax, 2318544757056020522
	mov	QWORD PTR [rsp+72], rax
	mov	DWORD PTR [rsp+80], 3088430
	movabs	rax, 2319670675685519411
	mov	QWORD PTR [rsp+96], rax
	movabs	rax, 2320796591229968434
	mov	QWORD PTR [rsp+104], rax
	movabs	rax, 2321922508316942390
	mov	QWORD PTR [rsp+112], rax
	movabs	rax, 2323048425403916346
	mov	QWORD PTR [rsp+120], rax
	mov	DWORD PTR [rsp+128], 4137022
	movabs	rax, 2324174344032366644
	mov	QWORD PTR [rsp+144], rax
	movabs	rax, 2325300259577864258
	mov	QWORD PTR [rsp+152], rax
	movabs	rax, 2326426176664838214
	mov	QWORD PTR [rsp+160], rax
	movabs	rax, 2327552093751812170
	mov	QWORD PTR [rsp+168], rax
	mov	DWORD PTR [rsp+176], 5185614
	movabs	rax, 2328678012379213877
	mov	QWORD PTR [rsp], rax
	movabs	rax, 2329803927925760082
	mov	QWORD PTR [rsp+8], rax
	movabs	rax, 2330929845012734038
	mov	QWORD PTR [rsp+16], rax
	movabs	rax, 6782523431383146586
	mov	QWORD PTR [rsp+24], rax
	mov	WORD PTR [rsp+32], 24352
	mov	BYTE PTR [rsp+34], 0
	movabs	rax, 2333181680726061110
	mov	QWORD PTR [rsp+192], rax
	movabs	rax, 2334307596273655906
	mov	QWORD PTR [rsp+200], rax
	movabs	rax, 2335433513360629862
	mov	QWORD PTR [rsp+208], rax
	movabs	rax, 2336559430447603818
	mov	QWORD PTR [rsp+216], rax
	mov	DWORD PTR [rsp+224], 7282798
	movabs	rax, 2337685349072908343
	mov	QWORD PTR [rsp+240], rax
	movabs	rax, 2338811264621551730
	mov	QWORD PTR [rsp+248], rax
	movabs	rax, 2339937181708525686
	mov	QWORD PTR [rsp+256], rax
	movabs	rax, 2341063098795499642
	mov	QWORD PTR [rsp+264], rax
	mov	DWORD PTR [rsp+272], 2105470
	lea	rdi, [rsp+288]
	call	puts
	lea	rdi, [rsp+336]
	call	puts
	lea	rdi, [rsp+48]
	call	puts
	lea	rdi, [rsp+96]
	call	puts
	lea	rdi, [rsp+144]
	call	puts
	mov	rdi, rsp
	call	puts
	lea	rdi, [rsp+192]
	call	puts
	lea	rdi, [rsp+240]
	call	puts
	mov	rdx, QWORD PTR [rsp+376]
	xor	rdx, QWORD PTR fs:40
	je	.L2
	call	__stack_chk_fail
.L2:
	mov	eax, 0
	add	rsp, 392
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
