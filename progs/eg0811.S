# eg811.S (GAS 汇编，16位实模式)
/*as --32 -o testdos.o ./progs/testdos.s
objcopy -O binary -j .text testdos.o testdos.com
objcopy 是 GNU Binutils 工具集中的一个重要命令，用于目标文件的转换和操作。
它的主要功能是复制和转换目标文件中的内容，常用于提取特定段、修改文件格式或调整二进制布局。
-O binary	输出为纯二进制格式
-j .text	只提取 .text 段（代码段）
*/
.code16                 # 16位代码
.intel_syntax noprefix  # 使用 Intel 语法

.text
.globl main           # 入口点

main:
   
    jmp L1
    msg:
    .ascii "Hello, DOS!$"  # DOS 字符串以 $ 结尾
    
L1:
    mov ax, cs          #将 .data 段地址存入 AX
    mov ds, ax          #  设置 DS = AX
    
    mov ah, 0x01        # DOS 功能号 0x01（输入字符）
    int 0x21            # 调用 DOS 中断，al=输入字符
    
    mov ah, 0x02        # DOS 功能号 0x02（显示字符）
    mov dl, al          # DL = 要显示字符的ASCII码
    int 0x21            # 调用 DOS 中断
    
    mov ah, 0x09        # DOS 功能号 0x09（显示字符串）
    mov dx, msg -main+0x100        # DS:DX = 要显示字符串的首地址，
                                   # msg - main = 字符串相对于代码开头的偏移
                                   # + 0x100 = 补偿 DOS 加载地址（CS:0100）
    /*mov dx,offset msg 或lea dx,msg可能产生 32位偏移，但实模式只需 16位。不建议使用*/
     int 0x21            # 调用 DOS 中断
    
    mov ax, 0x4C00      # DOS 功能号 0x4C（退出程序）
    int 0x21            # 退出，返回码 AL=00

    