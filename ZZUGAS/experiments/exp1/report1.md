### 1．记录按照实验步骤操作所得到的 eg0101.s 的内容。

```asm
	.file   "eg0101.c"
	.intel_syntax noprefix
	.text
	.globl  add
	.type   add, @function
add:
.LFB0:
	.cfi_startproc
	lea     eax, [rdi+rsi]
	ret
	.cfi_endproc
.LFE0:
	.size   add, .-add
	.ident  "GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section        .note.GNU-stack,"",@progbits
```


### 2．记录按照实验步骤操作所得到的 eg0102.s 的内容。

```asm
	.file   "eg0102.c"
	.intel_syntax noprefix
	.text
	.globl  add
	.type   add, @function
add:
.LFB23:
	.cfi_startproc
	lea     eax, [rdi+rsi]
	ret
	.cfi_endproc
.LFE23:
	.size   add, .-add
	.section        .rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string "%d"
	.text
	.globl  main
	.type   main, @function
main:
.LFB24:
	.cfi_startproc
	sub     rsp, 8
	.cfi_def_cfa_offset 16
	mov     esi, 256
	mov     edi, 100
	call    add
	mov     edx, eax
	mov     esi, OFFSET FLAT:.LC0
	mov     edi, 1
	mov     eax, 0
	call    __printf_chk
	mov     eax, 0
	add     rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size   main, .-main
	.ident  "GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section        .note.GNU-stack,"",@progbits
```


### 3．记录按照实验步骤操作 eg0101.o、 eg0101as.o、eg0101cc.o反汇编的结果。

三个目标文件反汇编结果一致，均为：

```text
### eg0101.o
eg0101.o:     file format elf64-x86-64

Disassembly of section .text:
0000000000000000 <add>:
   0:   8d 04 37                lea    (%rdi,%rsi,1),%eax
   3:   c3                      ret

### eg0101as.o
eg0101as.o:     file format elf64-x86-64

Disassembly of section .text:
0000000000000000 <add>:
   0:   8d 04 37                lea    (%rdi,%rsi,1),%eax
   3:   c3                      ret

### eg0101cc.o
eg0101cc.o:     file format elf64-x86-64

Disassembly of section .text:
0000000000000000 <add>:
   0:   8d 04 37                lea    (%rdi,%rsi,1),%eax
   3:   c3                      ret
```


### 4．记录按照实验步骤操作 eg0102.o 、eg0102_1、eg0102as.o、eg0102cc.o、eg0102_2反汇编的结果。

1) eg0102.o

```text
eg0102.o:     file format elf64-x86-64

Disassembly of section .text:
0000000000000000 <add>:
   0:   8d 04 37                lea    (%rdi,%rsi,1),%eax
   3:   c3                      ret

0000000000000004 <main>:
   4:   48 83 ec 08             sub    $0x8,%rsp
   8:   be 00 01 00 00          mov    $0x100,%esi
   d:   bf 64 00 00 00          mov    $0x64,%edi
  12:   e8 00 00 00 00          call   17 <main+0x13>
  17:   89 c2                   mov    %eax,%edx
  19:   be 00 00 00 00          mov    $0x0,%esi
  1e:   bf 01 00 00 00          mov    $0x1,%edi
  23:   b8 00 00 00 00          mov    $0x0,%eax
  28:   e8 00 00 00 00          call   2d <main+0x29>
  2d:   b8 00 00 00 00          mov    $0x0,%eax
  32:   48 83 c4 08             add    $0x8,%rsp
  36:   c3                      ret
```

2) eg0102_1（可执行文件，节较多，以下摘录关键部分）

```text
eg0102_1:     file format elf64-x86-64

Disassembly of section .text:
0000000000400546 <add>:
  400546:       8d 04 37                lea    (%rdi,%rsi,1),%eax
  400549:       c3                      ret

000000000040054a <main>:
  40054a:       48 83 ec 08             sub    $0x8,%rsp
  40054e:       be 00 01 00 00          mov    $0x100,%esi
  400553:       bf 64 00 00 00          mov    $0x64,%edi
  400558:       e8 e9 ff ff ff          call   400546 <add>
  40055d:       89 c2                   mov    %eax,%edx
  40055f:       be 04 06 40 00          mov    $0x400604,%esi
  400564:       bf 01 00 00 00          mov    $0x1,%edi
  400569:       b8 00 00 00 00          mov    $0x0,%eax
  40056e:       e8 bd fe ff ff          call   400430 <__printf_chk@plt>
  400573:       b8 00 00 00 00          mov    $0x0,%eax
  400578:       48 83 c4 08             add    $0x8,%rsp
  40057c:       c3                      ret
```

3) eg0102as.o

```text
eg0102as.o:     file format elf64-x86-64

Disassembly of section .text:
0000000000000000 <add>:
   0:   8d 04 37                lea    (%rdi,%rsi,1),%eax
   3:   c3                      ret

0000000000000004 <main>:
   4:   48 83 ec 08             sub    $0x8,%rsp
   8:   be 00 01 00 00          mov    $0x100,%esi
   d:   bf 64 00 00 00          mov    $0x64,%edi
  12:   e8 00 00 00 00          call   17 <main+0x13>
  17:   89 c2                   mov    %eax,%edx
  19:   be 00 00 00 00          mov    $0x0,%esi
  1e:   bf 01 00 00 00          mov    $0x1,%edi
  23:   b8 00 00 00 00          mov    $0x0,%eax
  28:   e8 00 00 00 00          call   2d <main+0x29>
  2d:   b8 00 00 00 00          mov    $0x0,%eax
  32:   48 83 c4 08             add    $0x8,%rsp
  36:   c3                      ret
```

4) eg0102cc.o

```text
eg0102cc.o:     file format elf64-x86-64

Disassembly of section .text:
0000000000000000 <add>:
   0:   8d 04 37                lea    (%rdi,%rsi,1),%eax
   3:   c3                      ret

0000000000000004 <main>:
   4:   48 83 ec 08             sub    $0x8,%rsp
   8:   be 00 01 00 00          mov    $0x100,%esi
   d:   bf 64 00 00 00          mov    $0x64,%edi
  12:   e8 00 00 00 00          call   17 <main+0x13>
  17:   89 c2                   mov    %eax,%edx
  19:   be 00 00 00 00          mov    $0x0,%esi
  1e:   bf 01 00 00 00          mov    $0x1,%edi
  23:   b8 00 00 00 00          mov    $0x0,%eax
  28:   e8 00 00 00 00          call   2d <main+0x29>
  2d:   b8 00 00 00 00          mov    $0x0,%eax
  32:   48 83 c4 08             add    $0x8,%rsp
  36:   c3                      ret
```

5) eg0102_2（可执行文件，关键部分与 eg0102_1 相同）

```text
eg0102_2:     file format elf64-x86-64

Disassembly of section .text:
0000000000400546 <add>:
  400546:       8d 04 37                lea    (%rdi,%rsi,1),%eax
  400549:       c3                      ret

000000000040054a <main>:
  40054a:       48 83 ec 08             sub    $0x8,%rsp
  40054e:       be 00 01 00 00          mov    $0x100,%esi
  400553:       bf 64 00 00 00          mov    $0x64,%edi
  400558:       e8 e9 ff ff ff          call   400546 <add>
  40055d:       89 c2                   mov    %eax,%edx
  40055f:       be 04 06 40 00          mov    $0x400604,%esi
  400564:       bf 01 00 00 00          mov    $0x1,%edi
  400569:       b8 00 00 00 00          mov    $0x0,%eax
  40056e:       e8 bd fe ff ff          call   400430 <__printf_chk@plt>
  400573:       b8 00 00 00 00          mov    $0x0,%eax
  400578:       48 83 c4 08             add    $0x8,%rsp
  40057c:       c3                      ret
```


### 5．编译时参数“-Og ”改成 “-O1、-O2、或-O3 ”所得到的汇编语言文件是否一样？你认为是什么原因？

不一样。

我在 bash 中执行了：

```bash
gcc -S -masm=intel -Og eg0102.c -o eg0102_Og.s
gcc -S -masm=intel -O1 eg0102.c -o eg0102_O1.s
gcc -S -masm=intel -O2 eg0102.c -o eg0102_O2.s
gcc -S -masm=intel -O3 eg0102.c -o eg0102_O3.s
```

得到结果：

```text
md5:
eg0102_Og.s  ec37631e9a3c47ef45551ad934a2c88e
eg0102_O1.s  3ba40b61318e6c5cf346f0cf3395bc33
eg0102_O2.s  68b6655ae2ab8f88e080218e5130c989
eg0102_O3.s  68b6655ae2ab8f88e080218e5130c989
```

说明：

1. Og 与 O1 不同：O1 把 add(100,256) 做了常量折叠，直接把 356 作为 printf 参数。
2. O1 与 O2 不同：O2 在代码布局、对齐和细节指令上进一步优化（如 .p2align、xor eax,eax 替代 mov eax,0）。
3. O2 与 O3 在本例中相同：程序规模很小，O3 的额外优化在该代码上没有触发更多变化。


### 6．目标文件 eg0102.o 和可执行文件 eg0102 反汇编结果是否一样？你认为是什么原因？

不一样。

原因：

1. eg0102.o 是可重定位目标文件，只包含本模块的代码和未解析重定位，函数调用地址通常还是占位值。
2. eg0102 是最终可执行文件，经过链接后补齐了启动代码和运行时支持代码（如 _start、plt、init、fini 等），并把外部符号地址解析为实际地址。
3. 所以二者反汇编在代码规模、节结构和地址上都明显不同；但业务函数 add/main 的核心逻辑是一致的。


### 7．根据 eg0101.s 和 eg0102.s 的共同部分，总结 GAS 汇编语言程序框架。

可总结为如下通用框架：

```asm
	.file   "xxx.c"                  # 源文件信息
	.intel_syntax noprefix            # 语法风格（可选）

	.section/.text                    # 代码段
	.globl  func                      # 导出符号
	.type   func, @function           # 符号类型
func:
	.cfi_startproc                    # 调试/回溯信息开始
	; 函数体（参数处理、运算、调用、返回）
	ret
	.cfi_endproc                      # 调试/回溯信息结束
	.size   func, .-func              # 函数大小

	.section .rodata                  # 常量区（字符串、常量）
label:
	.string "..."

	.ident  "GCC ..."                # 编译器标识
	.section .note.GNU-stack,"",@progbits
```

如果是完整程序，还会在 .text 中包含 main，并在函数里按调用约定设置参数后调用库函数。


### 8．写出汇编语言源程序 exp0104.s的源程序，汇编连接方法及运行结果截图。

exp0104.s 源程序如下：

```asm
	/* eg0103.s in Windows Terminal for GCC_64*/
	.intel_syntax noprefix

	.section .data
msg     :  .asciz "Hello, Assembly!\n"
	.section .text
	.globl main
main    :
	lea     rax,  msg[rip]        # 入口参数: 字符串首地址
	call    dispmsg
	#返回值
	xor     eax,eax               # 返回0
	ret
```

汇编与连接（bash 实测可运行）：

```bash
as -o exp0104_test.o exp0104.s
gcc -no-pie -o exp0104_test exp0104_test.o -L../../lib -l:io_linux64.a
```

运行结果：

```text
$ ./exp0104_test
Hello, Assembly!
exit code: 0
```

说明：截图可按以上命令在终端运行后截取。


### 9．总结汇编语言程序开发过程的经验体会，写出自己遇到的或感到困惑的问题等。

1. 先从 C 到汇编（-S）再到目标文件和可执行文件，有助于理解“编译、汇编、链接”三阶段职责。
2. 目标文件反汇编与可执行文件反汇编差异很大，关键在于链接阶段是否已经解析重定位并加入运行时启动代码。
3. 优化级别会显著改变汇编输出，尤其常量折叠、死代码消除、指令选择与代码布局；不要只看语句层面，要看最终机器指令。
4. 本实验遇到的主要困惑是：为什么直接链接 exp0104.s 会报 dispmsg 未定义。实践后确认它依赖实验库 io_linux64.a，且需用 -no-pie 以匹配库的重定位模型。
5. 开发建议：每一步都保留中间文件（.s/.o）并配合 objdump、nm、diff 做对照，定位问题会非常高效。


