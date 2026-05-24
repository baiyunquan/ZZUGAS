.data 
wbuf: .space 20 // 预留 20 个字节存储空间：二进制 64 位对应十进制 20 位 
cr: .ascii "\n" // 换行符 
.text 
.global _start // 主程序 
_start: 
ldr x0, =-123456789 // X0 = 假设一个要显示的数据（输入参数） 
bl dispsix // 调用十进制显示的子程序 
mov x0, 0 // 输入参数：X0 = 第 1 个参数（0 表示显示器）
ldr x1, =cr // X1 = 第 2 个参数（字符串首地址） 
mov x2, 1 // X2 = 第 3 个参数（字符串长度） 
mov x8, 64 // X8 = 系统功能（write）的调用号（64） 
svc 0 // 调用 Linux 系统功能，实现回车功能 
mov x0, 0 // X0 = 系统返回代码（通常 0 表示无错误） 
mov x8, 93 // Linux 系统功能（exit） 
svc 0 // 调用 Linux 系统，返回 

.global dispsix // 子程序 
.type dispsix, %function 
dispsix: 
adrp x1, wbuf 
add x1, x1,:lo12:wbuf // X1 指向存储器缓冲区 
cbnz x0, minus // 不是 0，跳转 
mov w3, '0' // 数据是 0 
strb w3, [x1] // 存储字符‘0’ 
mov x2, 1 // X2 = 第 3 个参数（字符串长度） 
b dpsx3 // 转向显示 
minus: 
mov x4, x0 
tbz x4, 63, plus // 最高位为 0（正数），跳转 
neg x4, x4 // 最高位为 1（负数），求补为绝对值 
mov w3, '-' 
strb w3, [x1] // 存储一个负号，表示负数 
mov x0, 0 // 输入参数：X0 = 第 1 个参数（0 表示显示器） 
// （已赋值）X1 = 第 2 个参数（字符串首地址） 
mov x2, 1 // X2 = 第 3 个参数（字符串长度） 
mov x8, 64 // X8 = 系统功能（write）的调用号（64） 
svc 0 // 调用 Linux 系统功能，显示负号 
plus: 
mov x2, 19 // X2 指向缓冲区尾部，因为先求得低位，但显示在后面
mov x5, 10 // X5 作为除数（10） 
dpsx1: 
udiv x6, x4, x5 // X6 是数据（X4）除以 10 的商 
msub x3, x6, x5, x4 // 取余数：X3 = X4 - X6×X5 
orr w3, w3, 0x30 // 余数加 0x30，转换为 ASCII 字符 
strb w3, [x1, x2] // 存入缓冲区
cbz x6, dpsx2 // 商为 0，结束除法，转向显示 
sub x2, x2, 1 // X2 指向前一个字符位置 
mov x4, x6 // 本次除法的商作为下次的被除数（数据） 
b dpsx1 // 继续做除法 
dpsx2: 
add x1, x1, x2 // X1 = 第 2 个参数（字符串首地址） 
mov x3, 20 
sub x2, x3, x2 // X2 = 第 3 个参数（字符串长度） 
dpsx3: 
mov x0, 0 // 输入参数：X0 = 第 1 个参数（0 表示显示器） 
mov x8, 64 // X8 = 系统功能（write）的调用号（64） 
svc 0 // 调用 Linux 系统功能，显示数据 
ret // 子程序返回 
