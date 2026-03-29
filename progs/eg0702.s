.data // 数据区 
msg: 
.string "Hello, ARMv8!\n" // 定义字符串（以 0 结尾） 
.text // 代码区 
.global main // 主函数 
main: 
stp x29, x30, [sp, -16]! // 保护寄存器 X29 和 X30 
adr x0, msg // 获取字符串地址 
bl printf // 调用 C 语言函数 printf 显示 
mov x0, 0 // 返回值 
ldp x29, x30, [sp], 16 // 恢复寄存器 X29 和 X30
ret // 主函数返回 
