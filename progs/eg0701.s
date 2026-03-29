.arch armv8-a /* 指示采用 ARMv8-A 体系结构 */
.file "e101_hello.c" /* 指示源程序文件名 */
.text /* 代码区  */
.section .rodata /* 只读数据区  */
.align 3 /* 8 字节地址对齐  */
.LC0: .string "Hello, world!" /* 定义字符串，编译器取名为.LC0  */
.text /* 代码区  */
.align 2 /* 4 字节地址对齐  */
.global main /* 定义 main 为全局标号  */
.type main, %function /* 指示 main 为函数  */
main: /* 主函数  */
.LFB0: /* 编译器添加的标号  */
.cfi_startproc /* 指示函数开始，用于初始化一些内部数据结构  */
stp x29, x30, [sp, -16]! /* 存储寄存器对指令：保存 X29 和 X30 寄存器  */
.cfi_def_cfa_offset 16 /* 指示修改调用帧的偏移量（16）  */
.cfi_offset 29, -16 /* 指示原 X29 寄存器内容保存于偏移量（-16）位置  */
.cfi_offset 30, -8 /* 指示原 X30 寄存器内容保存于偏移量（-8）位置  */
add x29, sp, 0 /* 加法指令：X29 = SP+0，实现赋值功能（MOV X29, SP）  */
.cfi_def_cfa_register 29 /* 指示寄存器 X29 替代 SP 作用  */
adrp x0, .LC0 /* 获取地址指令：X0 = 标号.LC0 高 21 位地址（低 12 位为 0） */
add x0, x0, :lo12:.LC0 /* 加法指令：X0 = X0 + 标号.LC0 低 12 位地址  */
bl puts /* 调用指令：调用 C 语言函数puts  */
mov w0, 0 /* 传送指令：W0 = 0（作为函数返回值）  */
ldp x29, x30, [sp], 16 /* 载入寄存器对指令：恢复 X29 和 X30 寄存器  */
.cfi_restore 30 /* 指示恢复 X30 寄存器的原来作用  */
.cfi_restore 29 /* 指示恢复 X29 寄存器的原来作用 */
.cfi_def_cfa 31, 0 /* 指示从 SP（编码为 31）取得地址  */
ret /* 返回指令：函数返回  */
.cfi_endproc /* 指示函数结束  */
.LFE0: /* 编译器添加的标号  */
.size main, .-main /* 设置 main 具有 main 函数的指令字节数  */
.ident "GCC: (GNU) 7.3.0" /* 给出注释信息，表明 GCC 版本 */
.section .note.GNU-stack,"",@progbits /* 指示这是包含数据的 GNU 栈区  */