.text 
.global strcpya // 子程序 
.type strcpya, %function 
strcpya: ldrb w2, [x1], 1 // 载入源字符串一个字符，并指向下一个字符 
strb w2, [x0], 1 // 存入目的字符串，并指向下一个位置 
cbnz w2, strcpya // 不是 0（结尾），继续复制 
ret 


