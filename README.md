# 郑州大学汇编语言实验 2026 Windows平台

在Windows上进行汇编语言程序的开发和调试，将使用MSYS2 UCRT64的gcc和gdb进行编译调试，完成和在实验平台Ubuntu 16.04相同的功能。

## 安装MSYS2 UCRT64
1. 访问MSYS2官网：https://www.msys2.org/，下载适用于Windows的安装程序并安装。
2. 安装完成后，打开MSYS2 UCRT64终端。
3. 更新软件包数据库和基础系统：
```bash
pacman -Syu
```
4. 安装gcc和gdb：
```bash
pacman -S --needed base-devel mingw-w64-ucrt-x86_64-toolchain
pacman -S mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-gdb
```
5. 配置环境变量

## 关于编译和调试

[task.json](task.json)和[launch.json](launch.json)已经配置好使用MSYS2 UCRT64的gcc和gdb进行编译和调试。Auto Debug ASM自带io_windows.a库。


## 关于io_windows64库

---

使用说明和测试报告请参见[io_windows64使用说明与测试报告](README_io_windows64.md)。  
功能和io_linux.a完全一致。

## 关于Win64和System V ABI的不同

---

### 1. 入口点与符号命名 (Symbol Naming)

这是你最先会遇到的不同点。

* **Linux (ELF):**
    符号通常不需要前缀。你的入口函数直接写成 `main`。
    ```gas
    .globl main
    main:
        # 代码
    ```
* **Windows (MinGW/Cygwin - PE/COFF):**
    在 32 位系统上，x86 汇编符号通常需要一个**下划线前缀** `_`。虽然在 64 位 (x64) 上这个差异逐渐消失，但为了兼容性，通常写成：
    ```gas
    .globl _main
    _main:
        # 代码
    ```
    此外，Windows 程序真正的入口通常是 C 运行库的 `mainCRTStartup`，它再调用你的 `main`。

---

### 2. 调用约定 (Calling Convention)

这是最核心的区别。当你想调用 `printf` 或其他库函数时，传参的方式完全不同。

| 特性 | Linux (System V ABI) | Windows (Microsoft x64 ABI) |
| :--- | :--- | :--- |
| **寄存器传参 (64位)** | `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9` | `rcx`, `rdx`, `r8`, `r9` |
| **影子空间 (Shadow Space)** | 不需要 | **必须**在栈上预留 32 字节的空间 |
| **栈对齐** | 调用前 16 字节对齐 | 调用前 16 字节对齐 |
| **浮点传参** | `xmm0` - `xmm7` | `xmm0` - `xmm3` |

**影子空间**是 Windows 的一大特色。即使你只用寄存器传参，你也必须在 `call` 之前执行 `subq $32, %rsp`，否则被调用函数可能会覆盖你的栈数据。

---

### 3. 段声明与伪指令

虽然 GAS 都支持 `.section`，但常见的默认段名略有不同：

* **Linux:** 常用 `.text`, `.data`, `.bss`。
* **Windows:** 同样支持这些，但有时会看到针对 PE 格式的特殊处理，比如 `.section .rdata`（只读数据）在 Windows 上更常见。

---

### 实例对比：实现 `exit(0)`

#### Linux (x86_64)
```gas
.section .text
.globl _start
_start:
    movq $60, %rax    # syscall: exit
    movq $0, %rdi     # status: 0
    syscall
```

#### Windows (x86_64, 假设链接了库)
```gas
.section .text
.globl main
main:
    subq $40, %rsp    # 预留影子空间 (32) + 对齐 (8)
    movq $0, %rcx     # 第一个参数
    call ExitProcess
    # 理论上不会运行到这里
```
