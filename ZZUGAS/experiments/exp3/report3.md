### 1. 实验报告

1、按照实验步骤完成实验。

已完成。三个实验程序均已在当前环境中验证，其中 `exp0301` 在后续间接寻址处会触发段错误，因此表 1 只记录到可稳定观察到的步骤。

2、记录按照实验步骤操作所得到的 **exp0301.s** 的内容。

```asm
.intel_syntax noprefix

.data
x:    .long 0x12345678, 0x9ABCDEF0, 0x3456789A
msg:  .ascii "effect address of x = "
y:    .ascii "12345"
.equ  len, .-x

.text
.globl main
.type  main, @function

main:

	mov rcx, len
	mov rax, -100

	mov bx, ax
	mov bl, al
	mov ah, al
	mov esi, eax

	mov eax, x[rip]
	mov eax, y[rip]
	mov rax, x[rip+4]
	mov rax, msg[rip]

	lea rax, x[rip]

	mov bl, [rax]
	mov bx, [rax]
	mov ebx, [rax]
	mov rbx, QWORD ptr [rax]

	mov bl, [rax+1]
	mov bx, [rax+2]
	mov ebx, [rax+4]
	mov rbx, [rax+8]

	mov rbx, 16

	mov ebx, [rax+rbx]
	mov ebx, [rax+rbx+2]
	mov ebx, [rax+rbx+4]

	mov eax, [rax+rbx*4]
	mov eax, [rax+rbx*4+32]

	mov eax, 0
	ret
```

3、用 **GDB** 观察 exp0301.s 中的变量，填写表 1。

**表 1 exp0301 单步调试结果**

GDB 调试指令如下：

```bash
gdb -q ./exp0301
set disassembly-flavor intel
b *main
run
x/i $pc
info registers rax rbx rcx rsi
si
si
si
si
si
x/16bx 0x601030
x/8bx 0x601052
x/32bx 0x60103c
```

| 指令 | 指令地址 | 机器码 | 寻址方式 | rax | rbx |
| :--- | :--- | :--- | :--- | :--- | :--- |
| mov rcx, len | 0x4004d6 | 48 c7 c1 27 00 00 00 | 立即数 |  |  |
| mov rax, -100 | 0x4004dd | 48 c7 c0 9c ff ff ff | 立即数 | 0xffffffffffffff9c | 0x0 |
| mov bx, ax | 0x4004e4 | 66 89 c3 | 寄存器低位传送 | 0xffffffffffffff9c | 0xff9c |
| mov bl, al | 0x4004e7 | 88 c3 | 寄存器低位传送 | 0xffffffffffffff9c | 0xff9c |
| mov ah, al | 0x4004e9 | 88 c4 | 寄存器低位传送 | 0xffffffffffff9c9c | 0xff9c |
| mov esi, eax | 0x4004eb | 89 c6 | 寄存器传送，32 位写入会零扩展 | 0xffffffffffff9c9c | 0xff9c |
| mov eax, x[rip] | 0x4004ed | 8b 05 3d 0b 20 00 | RIP 相对寻址 | 0x12345678 | 0xff9c |
| mov eax, y[rip] | 0x4004f3 | 8b 05 59 0b 20 00 | RIP 相对寻址 | 0x34333231 | 0xff9c |
| mov rax, x[rip+4] | 0x4004f9 | 48 8b 05 34 0b 20 00 | RIP 相对寻址 | 0x3456789a9abcdef0 | 0xff9c |
| mov rax, msg[rip] | 0x400500 | 48 8b 05 35 0b 20 00 | RIP 相对寻址 | 0x6120746365666665 | 0xff9c |
| lea rax, x[rip] | 0x400507 | 48 8d 05 22 0b 20 00 | RIP 相对寻址取地址 | 0x601030 | 0xff9c |
| mov bl, [rax] | 0x40050e | 8a 18 | 寄存器间接寻址 | 0x601030 | 0xff78 |
| mov bx, [rax] | 0x400510 | 66 8b 18 | 寄存器间接寻址 | 0x601030 | 0x5678 |
| mov ebx, [rax] | 0x400513 | 8b 18 | 寄存器间接寻址 | 0x601030 | 0x12345678 |
| mov rbx, QWORD ptr [rax] | 0x400515 | 48 8b 18 | 寄存器间接寻址 | 0x601030 | 0x9abcdef012345678 |
| mov bl, [rax+1] | 0x400518 | 8a 58 01 | 基址+位移 | 0x601030 | 0x9abcdef012345656 |
| mov bx, [rax+2] | 0x40051b | 66 8b 58 02 | 基址+位移 | 0x601030 | 0x9abcdef012341234 |
| mov ebx, [rax+4] | 0x40051f | 8b 58 04 | 基址+位移 | 0x601030 | 0x000000009abcdef0 |
| mov rbx, [rax+8] | 0x400522 | 48 8b 58 08 | 基址+位移 | 0x601030 | 0x656666653456789a |
| mov rbx, 16 | 0x400526 | 48 c7 c3 10 00 00 00 | 立即数 | 0x601030 | 0x10 |
| mov ebx, [rax+rbx] | 0x40052d | 8b 1c 18 | 基址+变址 | 0x601030 | 0x61207463 |

说明：程序在继续执行 `mov ebx, [rax+rbx+2]` 时会把 `0x61207463` 当成偏移量继续参与寻址，最终形成非法地址并在 GDB/直接运行时触发段错误，所以后续几条指令没有稳定结果。

4、变量 **x**，**y**，**msg** 的地址和值。

| 变量 | 变量起始地址 | 十六进制值 | 变量在内存中从低字节到高字节的存储顺序 |
| :--- | :--- | :--- | :--- |
| x | 0x601030 | 78 56 34 12 f0 de bc 9a 9a 78 56 34 | 78 56 34 12 f0 de bc 9a 9a 78 56 34 |
| y | 0x601052 | 31 32 33 34 35 | 31 32 33 34 35 |
| msg | 0x60103c | 65 66 66 65 63 74 20 61 64 64 72 65 73 73 20 6f 66 20 78 20 3d 20 | 65 66 66 65 63 74 20 61 64 64 72 65 73 73 20 6f 66 20 78 20 3d 20 |

说明：`msg` 和 `y` 都是用 `.ascii` 定义的，末尾没有自动补 `\0`；因此用 `x/s 0x60103c` 查看时会顺着后面的 `y` 一直显示成 `effect address of x = 12345`。

5、**eg0302.c** 的执行结果是什么？为什么？

在当前环境中，`exp0302` 的实际输出是：

```text
12345
-12345
0
12345
-12345
0
```

原因是：前两次输出是正常的数组访问；第三次 `array[2]` 已经越界，随后两次 `*pi` 的访问也分别落到越界位置。这个程序存在未定义行为，所以结果依赖具体编译器和内存布局。本次运行中越界位置恰好读到了 0。

6、写出 **exp0303.s** 源程序，粘贴运行截图。

```asm
.section .data
x:  .long 0x12345678
y:  .long 0x9ABCDEF0
m:  .long 0x3456789A
n:  .long 0x96543210
.equ DATA_LEN, 16

.section .text
.globl main
.type  main, @function

main:
	movl $n, %ebx
	movl (%ebx), %eax
	call dispsid

	movl $x, %ebx
	movl 12(%ebx), %eax
	call dispsid

	movl $1, %eax
	xorl %ebx, %ebx
	int  $0x80
```

运行结果：

```text
-1772867056
-1772867056
```

7、总结汇编语言程序开发过程的经验体会，写出自己遇到的或感到困惑的问题等。

这次实验里最直接的体会有三点：一是操作数大小会直接影响结果，尤其是 `mov eax, ...` 会把高 32 位清零，而 `mov ah, ...` 只改 AX 的高 8 位；二是 `.ascii` 不会自动补 `\0`，做字符串观察时要特别注意相邻变量会被连着显示；三是地址计算一旦把数据值继续当成地址使用，就很容易得到非法指针并触发段错误。

我最困惑的地方是 `exp0301` 里后半段寻址形式看起来只是演示，但实际执行时会很快把程序带入非法地址，所以调试时必须先理解每条指令是“读数据”还是“把数据再当地址继续读”。这次用 GDB 单步看寄存器变化后，这一点就清楚了。