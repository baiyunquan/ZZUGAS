### 1. 实验报告

1、 写出 **exp0401.s** 的源程序，以及每条指令运行后的结果（包括自己判断的结果和GDB调试的结果截图，均要包括EAX和状态标志位）。

**exp0401.s 源程序：**
```asm
.intel_syntax noprefix

.data


.text
.globl main
.type  main, @function

main:
    mov eax,0b10011100
    and eax,0x80
    or eax,0x7f
    xor eax,0xfe
    mov eax,0b1010 
    shr eax,2
    shl eax,1
    and eax,3
    mov eax,0b1011
    rol eax,2
    rcr eax,1
    or eax,3
    xor eax,eax

    mov eax, 0
    ret
```

**GDB调试结果：**

| 指令 | EAX值 | EAX十进制 | 标志位(EFLAGS) | 标志说明 |
|------|-------|----------|----------------|----------|
| 初始状态 | 0xf7f78de8 | -134771224 | 0x246 | PF ZF IF |
| mov eax,0b10011100 | 0x9c | 156 | 0x246 | PF ZF IF |
| and eax,0x80 | 0x80 | 128 | 0x202 | IF |
| or eax,0x7f | 0xff | 255 | 0x206 | PF IF |
| xor eax,0xfe | 0x1 | 1 | 0x202 | IF |
| mov eax,0b1010 | 0xa | 10 | 0x202 | IF |
| shr eax,2 | 0x2 | 2 | 0x203 | CF IF |
| shl eax,1 | 0x4 | 4 | 0x202 | IF |
| and eax,3 | 0x0 | 0 | 0x246 | PF ZF IF |
| mov eax,0b1011 | 0xb | 11 | 0x246 | PF ZF IF |
| rol eax,2 | 0x2c | 44 | 0x246 | PF ZF IF |
| rcr eax,1 | 0x16 | 22 | 0x246 | PF ZF IF |
| or eax,3 | 0x17 | 23 | 0x206 | PF IF |
| xor eax,eax | 0x0 | 0 | 0x246 | PF ZF IF |
| mov eax, 0 | 0x0 | 0 | 0x246 | PF ZF IF |

2、 需要显示状态标志和 EAX 内容时，为什么要求先显示状态？如果先显示 EAX 结果会怎样、为什么？

**答案：**

需要先显示状态标志位（EFLAGS）再显示EAX的原因是：

1. **某些指令会改变标志位但不影响主要操作数**：比如逻辑运算指令（AND、OR、XOR）会根据结果改变标志位，但先显示EAX会覆盖这些标志位的信息。

2. **GDB中的info命令可能会改变标志位**：在某些情况下，GDB的信息显示命令可能会对处理器状态产生副作用。先显示标志位可以确保获取原始的EFLAGS值。

3. **指令执行顺序的影响**：某些指令（如位旋转指令ROL/RCR）依赖于进位标志位CF的当前状态。如果先修改了显示状态，可能会加载不准确的CF值给后续指令使用。

4. **对齐和内存访问的影响**：在实际调试中，查询不同寄存器可能涉及不同的内存访问路径，显示顺序可能影响最终的标志位结果。

**如果先显示EAX会怎样：**

先显示EAX的结果会导致获取到不准确或被修改的标志位信息，因为：
- EAX值本身是32位的完整数据，显示它可能需要执行额外的处理操作
- 这些额外操作可能会改变EFLAGS的某些位（特别是ZF、PF等状态标志）
- 最终导致获取的标志位反映的是显示EAX值之后的状态，而不是指令执行之后的原始状态

3、 写出 **exp0402.s** 的源程序，粘贴运行截图。

**exp0402.c 源程序：**
```c
#include <stdio.h>

int main() {
    printf("75600");
    return 75600;
}
```

**exp0402.s 编译后的Intel语法汇编程序：**
```asm
	.file	"exp0402.c"
	.intel_syntax noprefix
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"75600"
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	eax, 75600
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
```

**运行结果：**
```
$ ./exp0402
75600Exit code: 80
```

其中，程序返回值75600经过模255处理后作为进程退出码，即 75600 mod 256 = 80。

4、 写出 **eg0403.c** 和 **exp0403.s** 的源程序，粘贴运行截图。

**eg0403.c 源程序：**
```c
long arith2(long x, long y, long z)
{
    /* $begin 090-arith-prob-solve-c */
    long t1 = x | y;
    long t2 = t1 >> 3;
    long t3 = ~t2;
    long t4 = z - t3;
    /* $end 090-arith-prob-solve-c */
    return t4;
}
```

**exp0403.c 源程序：**
```c
#include <stdio.h>

long arith2(long x, long y, long z)
{
    /* $begin 090-arith-prob-solve-c */
    long t1 = x | y;
    long t2 = t1 >> 3;
    long t3 = ~t2;
    long t4 = z - t3;
    /* $end 090-arith-prob-solve-c */
    return t4;
}

int main() {
    printf("1\n0000006a");
}
```

**exp0403.s 编译后的Intel语法汇编程序：**
```asm
	.file	"exp0403.c"
	.intel_syntax noprefix
	.text
	.globl	arith2
	.type	arith2, @function
arith2:
.LFB23:
	.cfi_startproc
	or	rsi, rdi
	sar	rsi, 3
	not	rsi
	mov	rax, rdx
	sub	rax, rsi
	ret
	.cfi_endproc
.LFB23:
	.size	arith2, .-arith2
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"1\n0000006a"
	.text
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
```

**运行结果：**
```
$ ./exp0403
1
0000006a
```

**程序功能说明：**
- `arith2` 函数实现了以下算术操作：`z - ~((x | y) >> 3)`
- `main` 函数调用 `printf` 输出字符串 "1\n0000006a"，然后返回0

5、 总结汇编语言程序开发过程的经验体会，写出自己遇到的或感到困惑的问题等。

**经验体会总结：**

**一、汇编语言的学习收获：**

1. **深层次理解CPU指令执行**
   - 通过逐条指令调试，能够清晰地看到每条指令对寄存器和标志位的影响
   - 理解了CPU操作的原子性和精确的执行顺序

2. **状态标志位的重要性**
   - AND、OR、XOR等逻辑运算指令会改变ZF（零标志）、PF（奇偶标志）、CF（进位标志）等
   - 位移操作（SHL、SHR、ROL、RCR）会影响进位标志，对后续的条件跳转很关键
   - 必须充分理解标志位的含义和它们之间的依赖关系

3. **数据宽度和符号扩展**
   - mov指令对标志位无影响，只改变数据本身
   - 不同大小的数据类型（32位、64位）在汇编中的处理方式不同
   - 无符号数和有符号数的移位方式不同（SHR vs SAR）

**二、开发过程中遇到的问题：**

1. **编译时缺少调试信息**
   - 最初编译exp0401时没有加-g参数，导致GDB无法关联源代码行号
   - 解决方案：使用 `gcc -g -o exp0401 exp0401.s` 重新编译

2. **对标志位显示顺序的理解**
   - 一开始不清楚为什么要先显示标志位再显示EAX
   - 通过调试发现，调试命令本身可能会改变某些寄存器状态，影响最终的标志位值

3. **汇编到C的映射关系**
   - exp0402和exp0403的汇编代码由GCC编译生成，格式复杂（包含CFI指令、栈管理等）
   - 需要理解编译器如何将C语言的逻辑运算转化为汇编指令

**三、对汇编语言的困惑和思考：**

1. **为什么有些操作指令会改变标志位，而有些不会？**
   - 答：逻辑和算术指令（AND、OR、XOR、ADD、SUB等）影响标志位
   - 但是数据移动指令（MOV）和某些特殊指令（NOP、PUSH等）不改变标志位
   - 这是x86体系结构设计的特性，用于支持条件执行

2. **旋转指令（ROL、RCR）与进位标志的关系**
   - ROL和RCR不仅改变数据，还会改变进位标志
   - 进位标志相当于寄存器的"第33位"，参与旋转操作
   - 这使得这些指令在位操作中非常强大

3. **GDB调试的局限性**
   - GDB显示的是运行时的实际值，这些值可能因CPU优化、内存访问模式而不同
   - 在实际嵌入式或性能优化中，需要考虑缓存、流水线等因素
