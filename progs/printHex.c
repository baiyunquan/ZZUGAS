/*
说明：
逐字节输出文件内容的程序printHex，用法：printHex 文件名
编译命令：
Windows: gcc -o printHex.exe printHex.c
Linux:   gcc -o printHex printHex.c
*/

#include <stdio.h>

int main(int argc, char * argv[]){
if(argc<2) 
printf("用法: %s <文件名>\n", argv[0]);

FILE * fp=fopen(argv[1],"rb");

    if (fp == NULL) {
        printf("无法打开文件\n");
        return 0;
    }

    int c;
    long offset = 0;
    
    while ((c = fgetc(fp)) != EOF) {
        if(offset % 15 == 0)
        printf("\n");        
       
        printf("%02x ", (unsigned char)c);
        
        offset++;
    }
    
    fclose(fp);
    
    printf("%s 长度 = %08l\n", offset);
   
    return 0;

}