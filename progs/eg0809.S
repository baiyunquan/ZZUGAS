.data 
wbuf: .space 16 // 预留 16 个字节存储空间，保存转换后的字符串 
cr: .ascii "\n" // 换行符 
.text 
.global _start // 主程序 
_start: 
ldr x0, =0x0123456789abcdef // X0 = 假设一个要显示的数据（输入参数） 
bl disphx // 调用十六进制显示的子程序 
mov x0, 0 // 输入参数：X0 = 第 1 个参数（0 表示显示器） 
ldr x1, =cr // X1 = 第 2 个参数（字符串首地址） 
mov x2, 1 // X2 = 第 3 个参数（字符串长度） 
mov x8, 64 // X8 = 系统功能（write）的调用号（64） 
svc 0 // 调用 Linux 系统功能，实现回车功能 
mov x0, 0 // X0 = 返回值（通常 0 表示无错误） 
mov x8, 93 // Linux 系统功能（exit） 
svc 0 // 调用 Linux 系统，返回 

.global disphx // 子程序 
.type disphx, %function 
disphx: 
adrp x1, wbuf 
add x1, x1,:lo12:wbuf // X1 指向存储器缓冲区 
mov x2, 0 // X2 用于循环计数和字符指针 
dphx1: 
ror x0, x0, 64-4 // 循环右移 64-4 位、即循环左移 4 位（高位先显示） 
and w3, w0, 0xf // 仅保留二进制低 4 位，对应十六进制 1 位 
orr w3, w3, 0x30 // 加 0X30，转换为 ASCII 字符 
cmp w3, 0x39 // 判断是字符'0'～'9'，还是'A'～'F' 
b.ls dphx2 
add w3, w3, 7 // 是'A'～'F'，其 ASCII 需再加 7 
dphx2: 
strb w3, [x1, x2] // 存入缓冲区 
add x2, x2, 1 // 下一个十六进制位 
cmp x2, 16 
b.lo dphx1 // 循环控制 
mov x0, 0 // 输入参数：X0 = 第 1 个参数（0 表示显示器） 
// （已赋值）X1 = 第 2 个参数（字符串首地址） 
// （已赋值）X2 = 第 3 个参数（字符串长度） 
mov x8, 64 // X8 = 系统功能（write）的调用号（64） 
svc 0 // 调用 Linux 系统功能 
ret // 子程序返回

