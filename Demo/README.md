《ARM64 汇编语言程序设计》实验
实验一ARM64 汇编语言开发过程
1. 实验目的
熟悉ARM64 汇编语言的语句格式和程序框架，掌握ARM64 汇编语言的开发。
2. 实验内容
（1）输出字符串Hello, World!
1）创建hello 目录
执行以下命令，创建hello 目录，存放该程序的所有文件，并进入hello 目录。
mkdir hello
cd hello
2）创建示例程序源码hello.s
执行以下命令，创建ARM64 汇编语言源程序hello.s。
vim hello.s
录入信息显示程序。
.section .data // 数据区
msg: .string "Hello, World!\n" // 定义字符串
.section .text // 代码区
.global main // 主函数
main: stp x29, x30, [sp, -16]! // 保护X29 和X30
adr x0, msg // 获取字符串地址
bl dispmsg // 调用dispmsg 显示
mov x0, 0 // 返回值
ldp x29, x30, [sp], 16 // 恢复X29 和X30
ret // 主函数返回
3）编译运行
保存示例源码文件，然后退出vim 编辑器。在当前目录中依次执行以下命令，进
行代码编译运行。
gcc -o hello hello.s libtest.a
./hello
（2）用公式n*(n+1)/2 计算1 到100 的和。
3. 实验指导
（1）从学习通的“资料”中下载IO4ARM.rar 文件，解压得到libtest.a 文件，上传到云
服务器自己的文件夹下。
（2）汇编开发工具GCC 和文本编辑器Vim
汇编连接命令：
gcc -o 可执行程序汇编语言源程序.s libtest.a
学习通2.3.4 GCC 开发过程
（3）GNU AS 常用汇编伪指令说明（学习通3.6.4）
. 常量表示：
十六进制数0x 开始，二进制数0b 开始，字符串常量"a "，字符常量'a'
. 注释用#或//开头
. 变量定义：
1) 变量名后面加":"
2) 伪指令前加"."
定义字节、字、双字和四字变量分别用.byte，.word，.long，.quad
字符串定义可以用.string, .ascii (没有结束标志)或.asciz(有'\0')
. 没有伪指令type，sizeof， lengthof
（4）汇编程序框架
.data // 数据区
//数据定义
.text // 代码区
.global main // 主函数
main:
//指令序列
ret // 主函数返回
（5）ARM 处理器及寄存器（学习通1.2.6）
（6）ARM 寻址方式（学习通4.7）
（7）ARM 通用指令（学习通5.2.7，5.3.10，6.8）
■ ARM汇编指令的语法格式
< opcode> { < cond> } { S} <Rd> , <Rn>, < shifter_ operand>
■ <opcode>指令助记符，如ADD
. { <cond> } ：指令执行的条件
·在A即v1v5 之前的版本中，所有指令都是有条件执行的
. ARMv5 开始，引入无条件执行的指令
·在ARMv8 的A64 中减少了条件执行指令的数量
■ {S} ：决定指令的操作是否影响CPSR
. <Rd> ：表示目标操作数寄存器
■ <Rn> ：表示包含第1 个操作数的寄存器
. <shifter_ operand> ：表示第2个操作数
（8）地址生成指令
1. 获取PC 相对地址指令
指令使用相对于当前指令地址PC 的偏移员表示存储骼位置．
ADR 指令获得一个标吵相对于当前PC 的地址：
心R Xd, l abel / / Xd = labc l 的地址(PC ＋ 偏移益）
labe l 标号表示当前指令的存储器地址( P C 值）相对于标号所在位萱的偏移
扇。ADR 指令的偏移党只有2 1 位编码， 只能表达相对当前PC 值土1 MB 范围。
获得更大范围的相对PC 地址， 可以使用ADRP 指令：
!\DRP Xd, label / / Xd = label 的地址(PC+ 屏蔽低1 2 位的偏移蜇）
ADRP 指令获取的存储器地址是PC 伯加1一．偏移屈齿2 1 位、低12 位被屏蔽
为0 的结果， 因此其范围可达土4G B 0 3 位） ．
3 载入地址伪指令
汇编程序为Mrch64 引入伪指令LOR, 其格式如下：
LDR Rd, a= l abcl / / Rd - label 的地址（数值）
注意， LDR 伪指令的等号”= “ 必不可少，否则就是L OR 指令。l abe l 可以
是变员名等标号（表示其存储器地址） ， 还可以是任何数值表达式。
伪指令LDR 的功能是将l abel 的地址传输给目的寄存器Rd, 虽与指令ADR
功能相同，但实现机制不同。AS 汇编程序先将l abe l 的地址保存千最近的数据缓
冲区( Literal poo l, 国内多译为文字池），然后生成LDR 指令从该存储器单元
载入label 的地址（数值）。汇编程序通常在代码区砬后距离LD R 指令不超过士
1MB 范围开辟文字池，以满足P C 相对地址的范围要求。
利用文字池载入地址的LDR 指令格式如下：
LDR Rd, label // Rd 一[label ]
这里的l abel 仍是土1MB 范围的P C 地址偏移蜇， LDR 指令从该处载入数据。
（9）STP 指令
stp 是ARM 汇编语言中的一个指令，用于将一组寄存器的值存储到内存中。
stp 是"Store Registers in Pair" 的缩写。
语法：
stp { xn | sp }, { xn | sp }, [r], {#imm}
参数：
{ xn | sp } 是一个寄存器，可以是x30（通常是lr 或链接寄存器）或sp
（堆栈指针）。
{ xn | sp } 是另一个寄存器，用于与第一个寄存器配对。
[r] 是目标内存地址的基地址寄存器。
{#imm} 是一个可选的偏移量，用于指定存储位置的具体偏移量。
示例代码：
stp x29, x30, [sp, -16]! // 将x29 和x30 压栈，并更新sp 的值
在这个例子中，stp 指令将寄存器x29 和x30 的值存储到当前堆栈顶部，然
后将堆栈顶部向下移动16 字节，并更新堆栈指针sp。后缀! 表示压栈后对寄存
器sp 进行修改。
stp x2, x3, [x0, #16] //将x2 和x3 压栈，在压栈前向上移动16 字节。
（10）LDP 指令
ldp 是ARM 汇编语言中用于从寄存器组或栈中加载双精度浮点寄存器（FP
Double-precision）的指令。它用于从内存地址加载128 位的数据到两个浮点寄
存器（通常是单独的浮点寄存器，但也可以是一个的高64 位和另一个的低64
位）。
语法如下：
LDP <Wt1>, <Wt2>, [<Xn|SP>], #<imm>
LDP <Wt1>, <Wt2>, [<Xn|SP>, #<imm>]!
LDP <Xt1>, <Xt2>, [<Xn|SP>], #<imm>
LDP <Xt1>, <Xt2>, [<Xn|SP>, #<imm>]!
这里<Wt1> 和<Wt2>是目标浮点寄存器，<Xn|SP> 是基址寄存器，<imm>
是一个常量偏移量。
例子：
ldp x29, x30, [sp], 16 // 将栈上偏移为sp 的16 字节处的数据加载到
x29 和x30，然后sp 增加16
4
在这个例子中，ldp 指令用于从当前的栈指针sp 所指向的位置加载两个64
位的值到浮点寄存器x29 和x30，然后更新栈指针sp 增加16 字节。
（11）BL 指令
bl 是ARM 汇编语言中的一个跳转指令，用于调用子程序。bl 指令在跳转到
子程序前会将下一条指令的地址保存在链接寄存器（LR）中，这样子程序在返回时
可以正确继续执行。
bl 指令的格式如下：bl <target_label>
其中<target_label> 是你想要跳转到的子程序的标签。
例如，假设你有一个子程序my_subroutine，你可以使用bl 指令从另一个标
签（比如my_label）调用它：
my_label:
...
bl my_subroutine
...
my_subroutine:
...
mov x0, #0 @ 返回0
ret @ 返回到bl 指令后续指令
在这个例子中，当执行到bl my_subroutine 时，执行流会跳转到
my_subroutine，并保存my_label 后面的指令地址以便返回。当my_subroutine
执行完毕并使用ret 指令返回时，执行流会回到保存在LR 中的地址继续执行。
4. 实验要求
（1）掌握ARM64 汇编语言的开发方法。有条件的话，可以使用录屏软件详细记录自
己的开发步骤，应配有文字或语音解说。
（2）总结ARM64 汇编语言程序开发过程的经验体会，写出自己遇到的或感到困惑的
问题等。

实验二分支和循环程序设计
1. 实验目的
理解分支和循环程序结构的特点，掌握分支和循环结构程序的编写。
2. 实验内容
（1）编写ARM64 汇编语言实现如下功能：在给定的一组整数中查找最大数。
（2）编写ARM64 汇编语言程序实现：复制字符串（C 语言strcpy 函数的功能）。
3. 实验指导
（1）ARM 顺序结构（学习通7.4）
（2）ARM 分支结构（学习通8.2.8、8.3.2、8.4.3）
（3）ARM 循环结构（学习通9.4）
（4）ARM 分支/跳转指令
绝对跳转指令说明
B 绝对跳转
BL 绝对跳转#imm，返回地址保存到LR（X30/R14）
BLR 绝对跳转reg，返回地址保存到LR（X30/R14）
BR 跳转到reg 内容地址,
RET 子程序返回指令，返回地址默认保存在LR（X30）
特殊、条件跳转指令说明
B.cond cond 为真跳转
CBNZ CBNZ X1，label //如果X1!=0 则跳转到label
CBZ CBZ X1，label //如果X1==0 则跳转到label
TBNZ TBNZ X1，#3,label //若位X1[3]!=0,则跳转到label
TBZ TBZ X1，#3,label //若位X1[3]==0,则跳转到label

条件选择指令
指令名称指令格式I 条件成立条件不成立
条件选择CSEL Rd, Rn, Rm, cond Rd ;;; Rn Rd = RnI
条件选择增尽CSINC Rd, Rn, R川， cond Rd= Rn Rd= Rm + 1
条件选择求反CSif\V Rd, Rn, Rtn, cond Rd= Rn Rd= ~Rm （求反）
条件选择求补CSNEG Rd . 化，仙JJ, cond Rd= Rn Rd= - Rm （求补）
条件卅拭crnc Rd, Rn, cond Rd= !In + I Rd= Rn
条件求反CI t\'V Rd, Rn, cond Rd "'~ Rn ｛求反） Rd-"' Rn
条件求补CNEG Rd, Rn, cond Rd= -Rn （求补） Rd = Rn
条件置位CSET Rd, cond Rd = l Rd = 0
条件屏蔽CSEnl Rd, cond Rd= 一l ｛各位全l) Rd = 0

（5）调用C 语言函数printf 输出信息的方法
.section .data
print_data:
.string "bigger data is:%d\n"
.section .text
mov x1, #100 //x1=要输出的数据，如果有多个数据，依次使用x1…x7，
ldr x0, =print_data //x0=字符串首地址
bl printf //调用C 语言printf 函数
//详见实验三实验指导的ARM 子程序调用机制
4. 实验要求
（1）总结循环程序结构的应用特点和编程体会，分析自己实现的本实验程序流程，给
出核心代码并解释。
（2）整理实验完成的具体内容，提交ARM 实验报告1。

实验三子程序设计
1. 实验目的
理解子程序结构的特点，熟悉子程序参数传递的方法，掌握子程序的编写。
2. 实验内容
（1）编写子程序实现实验二的字符串复制功能、并编写验证子程序功能的主程序。
（2）（可选）在GDB 中调试自己编写的本实验要求的程序，注意查看堆栈的变化。
3.实验指导
（1）ARM 子程序设计（学习通10.4）
//子程序调用/返回示例
BL func //调用子程序func
…
func:
…
RET //64 位程序的子程序返回

（2）ARM 子程序调用机制
． 传递参数
· 寄存器： XO-X7 (SIMD/浮点用VO-V7)
· 栈： A64 没有push/pop指令，用STP/L DP寄存器对的存储
器访问指令
． 返回值
. XO-X7 (SIMD/浮点用VO-V7)
. X8 （ 结果地址，例如返回大的结构体时）
． 调用者保存： X9-X15, V16-V31
． 被调用者保存： X19-X29 、V8-V15
． 返回地址： X30(LR)
■ Frame指针： X29(FP)

4. 实验要求
（1）总结子程序结构的应用特点和编程体会，分析自己实现的本实验程序的参数传递
和调用流程，给出核心代码并解释。
（2）整理实验完成的具体内容，提交ARM 实验报告2。


8
实验四与C 语言的混合编程
1. 实验目的
熟悉模块连接和嵌入汇编生成可执行文件的混合编程方法。
2. 实验内容
（1）汇编语言调用C 函数（返回两个int 整数中的较大者）。
比较函数：C 代码文件compare.c。
主程序：ARM 汇编代码文件main.s。
（2）C 语言调用汇编子程序（实验三字符串复制）。
字符串复制子程序：ARM 汇编代码文件strcpy1.s。
主函数：C 代码文件main.c。
（3）C 代码中嵌入汇编代码（返回两个int 整数中的较大者）。
3. 实验指导
（1） C 语言调用汇编函数
需要在汇编代码中声明全局符号（函数或变量）。
.global compare_data
C 代码中用extern 声明函数。
extern int compare_data(int a, int b);
（2） GCC 内联汇编
GCC 内联汇编的语法格式为：asm("assembly code" : output : input : cl
obber);。其中"assembly code"是嵌入的汇编代码；output 是输出的寄存器或变
量；input 是输入的寄存器和变量；clobber 是需要维护的破坏上下文的寄存器。
“输入”是指C 代码传递给汇编代码的数据。
“输出”是值汇编代码传递给C 代码的数据。
内联汇编中的%0 等符号对应着约束中指定的操作数，即output 为开始的索
引。
（3） 混合编程编译方法
gcc asm_code.s c_code.c -o exefile
4. 实验要求
（1）总结模块连接和嵌入汇编的开发方法，比较各自的应用特点。
（2）整理实验完成的具体内容，提交ARM 实验报告3。

实验五利用鲲鹏处理器的流水线来优化汇编代码性能
1. 实验介绍
（1）关于本实验
实现GNU ARM 汇编中如何利用Aarch64 架构“其访存单元支持每拍2 条读或写
访存指令”的特性，来提升改进代码，提高代码执行效率。
（2）教学目标
掌握利用Aarch64 架构下的提高汇编代码执行效率的方式。
（3）实验内容介绍
关于在C 代码和汇编代码之间进行参数传递，根据Arm 公司的AAPCS64，
即Aarch64 程序调用标准，Aarch64 标准提供了8 个通用寄存器（x0-x7）用于传
递函数参数，依次对应于参数0、参数1、参数2…参数7。第8 个参数需要通过
sp 访问，第9 个参数需要通过sp + 8 访问，第n 个参数需要通过sp + 8*(n-8)访
问。一般来说，对于只带有少量参数的函数，仅使用寄存器就足够了；超过8 个
的参数会存放在堆栈中用于传递给子例程。在本例子中，需要传递的参数有三个：
第一个参数是目标字符串的首地址，用寄存器X0 来传递；第二个参数是源字符
串的首地址，用寄存器X1 来传递；第三个参数是传输的字节数目，用寄存器
X2 来传递。
在使用ldrb/ldp 和str/stp 等访存指令时，要注意区分这三种形式：
 前索引方式，形如：ldrb w2,[X1,#1]
//将x1+1 指向的地址处的一个字节放入w2 中；x1 寄存器的值保持不变。
 自动索引方式，形如：ldrb w2,[X1,#1]！
//将x1+1 指向的地址处的一个字节放入w2 中；然后x1+1->x1。
 后索引方式，形如ldrb w2,[X1],#1
//将x1 指向的地址处的一个字节放入w2 中，然后x1+1->x1。
该程序由两部分组成：第一部分是主函数，采用Linux C 语言编码，用来测试内存拷贝
函数的执行时间；第二部分是内存拷贝函数，采用GNU Arm64 汇编语言编码。在下面的代
码中，用到了上面三种形式的指令，需仔细体会其不同。
为了较为准确的测量内存拷贝函数memorycopy()的执行时间，调用了clock_gettime()
来分别记录memorycopy()执行前和执行后的系统时间，以纳秒为计时单位。
2. 实验任务操作指导
（1）创建原始示例程序源码
以下步骤以在华为鲲鹏云服务器上执行为例。
步骤1 执行以下命令，创建memorycopy 目录存放该程序的所有文件, 并进入该目录
cd
mkdir memorycopy
cd memorycopy
步骤2 执行以下命令，创建主函数的Linux C 代码memorycopy.c
vim memorycopy.c
代码内容如下：
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define len 60000000
char src[len],dst[len];
long int len1=len;
extern void memorycopy(char *dst,char *src,long int len1);
int main()
{
struct timespec t1,t2;
int i,j;
for(i=0;i<len-1;i++)
{
src[i]='a';
}
src[i]=0;
clock_gettime(CLOCK_MONOTONIC,&t1);
memorycopy(dst,src,len1);
clock_gettime(CLOCK_MONOTONIC,&t2);
printf("memorycopy time is %11u ns\n",t2.tv_nsec-t1.tv_nsec);
return 0;
}
步骤3 执行以下命令，创建内存拷贝函数的GNU Arm64 汇编语言编码copyfunc.s
vim copyfunc.s
代码内容如下：
.global memorycopy
memorycopy:
ldrb w3,[x1],#1
str w3,[x0],#1
sub x2,x2,#1
cmp x2,#0
bne memorycopy
ret
说明：内存拷贝函数memorycopy()的功能是实现将尺寸为len（这里设为
60000000 ） 的src 字符数组的内容拷贝到同样尺寸的dst 字符数组中。
memorycopy()函数用Arm64/Aarch64 汇编代码实现。根据所用访存指令和循环展
开粒度的不同，可以有多种实现方式。以上的汇编代码是最原始的方式，不进行
循环展开，每次循环只使用1 个ldrb 和1 个str 指令。
（2）进行原始程序的编译运行
保存示例源码文件，然后退出vim 编辑器。在当前目录中依次执行以下命令，
进行代码编译运行。
gcc copyfunc.s memorycopy.c -o m1
./m1
通过上述代码运行，可以看出,原始方法编写的memorycopy 示例程序已经在
华为鲲鹏云服务器上通过编译和运行，已经成功输出结果，可以看到执行时间为
46620054 纳秒。
（3）代码的第一阶段改进
采用循环展开的方法，充分利用流水线的多发射机制，对函数memorycopy()
原始汇编代码主体部分的两种改进，方式如下：
方法1：循环展开的宽度为2。将该方法命名为copyfunc_v2_1.s，汇编代码内容
如下：
.global memorycopy
memorycopy:
sub x1,x1,#1
sub x0,x0,#1
lp:
ldrb w3,[x1,#1]
ldrb w4,[x1,#2]!
str w3,[x0,#1]
str w4,[x0,#2]!
sub x2,x2,#2
cmp x2,#0
bne lp
ret
方法2：循环展开的宽度为4。将该方法命名为copyfunc_v2_2.s，汇编代码内容
如下：
.global memorycopy
memorycopy:
sub x1,x1,#1
sub x0,x0,#1
lp:
ldrb w3,[x1,#1]
ldrb w4,[x1,#2]
ldrb w5,[x1,#3]
ldrb w6,[x1,#4]!
str w3,[x0,#1]
str w4,[x0,#2]
str w5,[x0,#3]
str w6,[x0,#4]!
sub x2,x2,#4
cmp x2,#0
bne lp
ret
（4）代码第一阶段改进版的编译运行
分别保存两段新的汇编源码文件，并退出vim 编辑器。在当前目录中依次执
行以下命令，进行代码编译运行。
gcc copyfunc_v2_1.s memorycopy.c -o m21
./m21
gcc copyfunc_v2_2.s memorycopy.c -o m22
./m22
从以上的测试结果可以看出，这两种改进后代码的性能都要优于原始代码，
这两种改进代码之间的性能相差则不大。
原因分析：鲲鹏920 有两个load/store 流水线，其访存单元支持每拍2 条读
或写访存操作。原始代码下由于源字符串的地址和目标的字符串的地址并不连
续，而且这种不连续地址的一读一写交替进行，导致内存访问的连续性很差，
cache 命中率较低。另一方面，由于循环分支指令较多，会经常刷新流水线，这
也大大降低了两个访存指令发射队列中访存指令的充满速度。比起原始代码，改
进代码则有效改进了这些缺点，使得其访存延迟大大降低。
（5）代码的第二阶段改进
第一次改进中中每次读/写内存都是以一个字节为单位进行的，其访存效率
较低。可以采用一次读/写16 个字节的方法，充分利用内存突发传输方式的优势
（即内存在连续读/连续写多个数据时，其性能要优于非连续读/写数据的方式），
对上一节的代码再次进行改进。Arm64/Aarch64 提供了ldp 指令和stp 指令，这
两条指令可以一次访问16 个字节的内存数据，其读/写内存的连续性非常高，可
以有效降低访存延时。使用ldp 和stp 指令进行改进有如下三种典型的改进方式：
方法1：未经循环展开。将该方法命名为copyfunc_v3_1.s，汇编代码内容如下：
.global memorycopy
memorycopy:
ldp x3,x4,[x1],#16
stp x3,x4,[x0],#16
sub x2,x2,#16
cmp x2,#0
bne memorycopy
ret
方法2：循环展开的宽度为2。将该方法命名为copyfunc_v3_2.s，汇编代码内容
如下：
.global memorycopy
memorycopy:
sub x1,x1,#16
sub x0,x0,#16
lp:
ldp x3,x4,[x1,#16]
ldp x5,x6,[x1,#32]!
stp x3,x4,[x0,#16]
stp x5,x6,[x0,#32]!
sub x2,x2,#32
cmp x2,#0
bne lp
ret
方法3：循环展开的宽度为4。将该方法命名为copyfunc_v3_3.s，汇编代码内容
如下：
.global memorycopy
memorycopy:
sub x1,x1,#16
sub x0,x0,#16
lp:
ldp x3,x4,[x1,#16]
ldp x5,x6,[x1,#32]
ldp x7,x8,[x1,#48]
ldp x9,x10,[x1,#64]!
stp x3,x4,[x0,#16]
stp x5,x6,[x0,#32]
stp x7,x8,[x0,#48]
stp x9,x10,[x0,#64]!
sub x2,x2,#64
cmp x2,#0
bne lp
ret
（6）代码第二阶段改进版的编译运行
分别保存两段新的汇编源码文件，并退出vim 编辑器。在当前目录中依次执
行以下命令，进行代码编译运行。
gcc copyfunc_v3_1.s memorycopy.c -o m31
./m31
gcc copyfunc_v3_2.s memorycopy.c -o m32
./m32
gcc copyfunc_v3_3.s memorycopy.c -o m33
./m33
经测试，上述三种改进代码的性能要远远高于第一阶段的改进代码。
在上述各改进代码中，各同一类型的访存指令之间（比如各ldrb 指令之间，
各stp 指令之间）是没有依赖关系的（既没有寄存器资源的依赖，也没有数据的
依赖），因此在循环展开之后就可以充分两条load/store 流水线来并行地执行这
些访存指令，从而有效提升访存性能。如果改进代码中访存指令之间存在依赖关
系，例如如下的情况：
ldrb w3,[x1],#1
ldrb w4,[x1],#1
…..
后一条ldrb 指令中x1 的取值依赖于前一条ldrb 执行完毕之后x1 取值的更
新，那么这种改进的效果就会差很多。感兴趣的读者可以试写一下这种有依赖关
系的代码，将其与无依赖关系的改进代码进行性能对比。
3. 实验要求
（1）总结利用鲲鹏处理器的流水线来优化汇编代码的方法。