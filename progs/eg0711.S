# eg0528s.s arm

.text
.global dprf 
.global main
main:
  stp x29, x30, [sp, -32]!  /*保存 FP 和 LR*/
  mov x29, sp               /*  设置帧指针*/
  str x19, [sp, 16]      /*  保存被调用者寄存器*/
 mov w0, -1
 adds w0, w0,-1
 bl dprf
 ldr x19, [sp, 16]         /*  恢复 x19*/
 ldp x29, x30, [sp], 32    /*  恢复 FP 和 LR*/
 mov x0, 0
 ret


dprf:
   
   stp x29, x30, [sp, -80]!  /*保存 FP 和 LR*/
   mov x29, sp               /*  设置帧指针*/
   str x19, [sp, 16]      /*  保存被调用者寄存器*/
   /* 指令序列 */
  mrs x0, nzcv   /* X0=NZCV，D31:N, D30:Z,D29:C,D28:V */
  str x0,[sp,32]
   
   movz w1, #0x4652        // 将低16位设为 0x4652，其余位清零
   movk w1, #0x414C, lsl #16 // 将高16位设为 0x414C，保留低16位

   str w1, [sp,40]
 
   movz w1, #0x5347        // 将低16位设为 0x5347，其余位清零
   movk w1, #0x3D20, lsl #16 // 将高16位设为 0x3D20，保留低16位
   str w1, [sp,44] 
   
   ldr x1, [sp,32]   //mov eax, 32[rsp]
   add x3, sp,48  //lea rsi, 56[rsp]
   bl hdtoasc
   
   tst x1,0x80000000//N
   beq LZ
   mov w2,0x5320
   strh w2,[x3]
   add x3,x3,2
   
   LZ:
   tst x1,0x40000000 //Z
   beq LC
   mov w2,0x5a20
   strh w2,[x3]
   add x3,x3,2

   LC:
   tst x1,0x20000000 //C
   beq LV
   mov w2,0x4320
// strh w2,[x3,2]!
   strh w2,[x3]
   add x3,x3,2

   LV:
   tst x1,0x20000000 //V
   beq L1
   mov w2,0x4f20
  // strh w2,[x3,2]!
   strh w2,[x3]
   add x3,x3,2
  
   L1: mov w2,'\n'
   strb w2,[x3]
   mov w2,0
   strb w2,[x3,1]

   add x0,sp,40 
   bl	printf  

   ldr x19, [sp, 16]         /*  恢复 x19*/
   ldp x29, x30, [sp], 80    /*  恢复 FP 和 LR*/  
   ret                       /*  返回*/
   
hdtoasc: # x1,x3
    stp x29, x30, [sp, -32]!  /*保存 FP 和 LR*/
    mov x29, sp               /*  设置帧指针*/
    str x19, [sp, 16]      /*  保存被调用者寄存器*/
	mov w5,w1	
	mov w4,8	
again:	ror w5,w5,#(32-4)	
	bl htoasc	
    strb w6,[x3]
	add x3,x3,1
	subs w4,w4,1
    bge  again  
    ldr x19, [sp, 16]         /*  恢复 x19*/
    ldp x29, x30, [sp], 32    /*  恢复 FP 和 LR*/
	ret

htoasc:	
    mov w6,w5
   	and w6,w6,0xf	
	orr w6,w6,0x30	
	cmp w6,0x39	
	bls htoend
	add w6,w6,7	
htoend: ret	
