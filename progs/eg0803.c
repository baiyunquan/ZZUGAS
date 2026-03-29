#include <stdio.h>
#define COUNT 10
int mean(int d[], int num);
int add_two(int src, int dst);

int main()
{
  int array[COUNT] = {675, 354, -34, 198, 267, 0, 9, 2371, -67, 4257};
  printf("The mean is \t %d\n",mean(array,COUNT));
  
  return 0;
}
int mean(int d[], int num)
{
  int temp;	// 定义局部变量，用于返回值
  asm volatile (	// 嵌入式汇编代码部分（参考例程4-18）
  
   ".intel_syntax noprefix\n" // 切换到Intel语法
   
	"mov rbx, %1\n"	//;EBX＝数组地址
	"mov ecx,dword ptr %2\n"	//ECX＝数据个数
   
	"xor eax,eax\n"	//EAX保存和值"
	"xor edx,edx\n"	//EDX＝指向数组元素"
"mean1:\n"	
    "add eax,[rbx+rdx*4]\n"	//求和,64位x86寻址，地址为64位

	"add edx,1\n"	//指向下一个数据"
	"cmp edx,ecx\n"	//比较个数"
	"jb mean1\n"	//循环
	"cdq\n"	//将累加和EAX符号扩展到EDX
	"idiv ecx\n"	//有符号数除法，EAX＝平均值（余数在EDX中）
	"mov %0,eax\n"
   
    :"=m" (temp) //输出
    :"m" (d), "m" (num) //输入
    : "rax",  "rdx", "cc"//, "memory" // 破坏列表
  );

  return(temp);
}