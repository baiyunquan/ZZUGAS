.intel_syntax noprefix

.section .text
.globl main
main:
    sub     rsp, 40         /* 影子空间(32字节) + 参数空间(8字节) + 对齐 */

    /* 调用MessageBoxA */
    xor     r9d, r9d        /* uType = MB_OK (0) */
    lea     r8, [rip + caption] /* lpCaption */
    lea     rdx, [rip + message] /* lpText */
    xor     rcx, rcx        /* hWnd = NULL */
    call    MessageBoxA

    /* 调用ExitProcess */
    xor     rcx, rcx        /* uExitCode = 0 */
    call    ExitProcess

    add     rsp, 40         /* 恢复栈指针 */
    ret

.section .data
message:
    .asciz  "你好，汇编语言！"
caption:
    .asciz  "欢迎"
    