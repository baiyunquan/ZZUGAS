.text
.global main
main:

mov  x0, #0x12340000      // 高16位,x0=0x12340000
movk x0, #0x5678, lsl #0  //低16位（合并后 x0 = 0x12345678）
movk x0, #0x9ABC, lsl #32 // x0=0x9abc12345678

mov x0, #0x0000FFFF //0xffff
//mov x0, #0x12345678 //非法，immediate cannot be moved by a single instruction

mov  x0, #0x12340000      //高16位（0x1234 << 16）,x0=0x12340000
movk x0, #0x5678          //低16位（合并后 x0 = 0x12345678）

ldr x0, =0x12345678 //x0 = 0x12345678

//mov  x2, #0x12345      //非法，immediate cannot be moved by a single instruction

//movz x0, #0x1234, lsl #16  // x0 = 0x0000123400000000
mov  x1, #0xFFFF0000FFFF0000 //= 0xffff0000ffff0000
movk x1, #0x1234, lsl #0    // = 0xffff0000ffff1234
movz x1, #0xABCD, lsl #48   // = 0xabcd000000000000, 分号注释也可以
mov  x2, #0x10000             // 高16位（0x1 << 16），= 0x10000
movk x2, #0x2345, lsl #0  //低16位（合并后 x2 = 0x12345）

ldr x2, =0x12345          //x2=0x12345, 编译器自动生成合法指令序列

add x0, x1, #0xFF  //x1= 0xabcd000000000000,x0=0xabcd0000000000ff
add x0, x1, #0x1000 //x0 = 0xabcd000000001000  ,x1= 0xabcd000000000000
//add x0, x1, #0x12345  //非法，immediate out of range

add x0, x1, #0x12000  // 先加 0x12000（= 0x12 << 12）,x0 =0xabcd000000012000 ,x1 =  0xabcd000000000000
add x0, x0, #0x345     // 再加 0x345,x0 = 0xabcd000000012345,x1 = 0xabcd000000000000


ldr  x2, =0x12345      //编译器自动生成合法加载指令,x2 = 0x12345
add  x0, x1, x2        //x0 = x1 + 0x12345= 0xabcd000000012345

//ldr x0, [x1, #255]
//ldr x0, [x1, #256]//（非法，需用基址寄存器 + 偏移寄存器）。

//add  x1, x1, #256       //先计算新地址 x1 = x1 + 256
//ldr  x0, [x1]           //再从新地址加载数据到 x0

//mov  x2, #256           // 将偏移量 256 存入寄存器 x2
//ldr  x0, [x1, x2]       //使用寄存器偏移 [x1 + x2]

//ldr  x0, [x1, #255]     //第一次加载 [x1 + 255]
//ldr  x0, [x0, #1]       //第二次加载 [x0 + 1]（需确保 x0 是地址）,注意这两个地址是不能被用户访问的

cmp x0, #0xFF    // 合法, x0= 0xabcd000000012345,  CSPR=0xa0200000 , [ EL=0 SS C N ]
cmp x0, #0x1000  //合法（#1 << 12）,cpsr   = 0xa0200000 , [ EL=0 SS C N ]
cmp x0,-3000     //合法,cpsr =0x80200000, [ EL=0 SS N ]
CMP  x0, #0xFFF      // 合法（4095，12位最大值）,cpsr =  0xa0200000, [ EL=0 SS C N ]
CMP  x0, #0xABC000   //合法（0xABC << 12）,cpsr =0xa0200000 , [ EL=0 SS C N ]
//CMP  x0, #0x1234     // 非法（4660 > 4095，且无法通过移位表示）
//CMP  x0, #0x1001     //非法（0x1001 不能表示为 n << 12）
//cmp x0,0x1234   //非法，超出12位数范围,Error: immediate out of range
/*SUBS的立即数有严格限制：12位立即数：（即 0x000-0xFFF），或可以左移 12 位（即 #<imm> << 12）获得*/

mov  x2, #-3000         // 先加载大立即数到寄存器,x2  = 0xfffffffffffff448= -3000
cmp  x1, x2             //再比较,cpsr = 0x80200000 ,[ EL=0 SS N ]

bic x0, x0, #0xFF    //x0 = 0xabcd000000012300
//bic x0, x0, #0x1234  // 非法,immediate out of range at operand 3 -- `bic x0,x0,#0x1234'
//and  x0, x0, #0x1234   //非法，immediate out of range at operand 3 -- `and x0,x0,#0x1234'
mov  x1, #0x1234         //先将 0x1234 加载到临时寄存器 x1= 0x1234  
bic  x0, x0, x1          //x0 = x0 & ~x1,x0 = 0xabcd000000012100

ldr  x1, =0x1234         //让编译器自动加载常量,x1= 0x1234
bic  x0, x0, x1  //x0 = 0xabcd000000012100

mov  w0, #0x12340000      // 高16位（0x1234 << 16）,x0 = 0x12340000
movk w0, #0x5678, lsl #0  //低16位（合并后 x0 = 0x12345678）,x0=0x12345678


