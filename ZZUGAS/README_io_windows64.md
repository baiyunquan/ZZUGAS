# io_windows64 使用说明与测试报告

## 1. 目标

该库提供 Windows x64 控制台下可供汇编示例直接调用的 I/O 例程，接口风格与现有实验代码一致（参数主要走 `RAX/AL/AX/EAX`）。

- 头文件: `ZZUGAS/io_windows.inc`
- 静态库: `ZZUGAS/lib/io_windows64.a`
- C 实现: `ZZUGAS/lib/io_windows64_impl.c`
- 汇编包装: `ZZUGAS/lib/io_windows64_wrappers.S`

## 2. 构建库

在工作区根目录执行（MSYS2 mingw64 gcc）：

```powershell
Set-Location 'c:\workspace\ZZUGAS'
$gcc='C:\workspace\soft\msys2\mingw64\bin\gcc.exe'
$ar='C:\workspace\soft\msys2\clang64\bin\ar.exe'

& $gcc -c 'ZZUGAS/lib/io_windows64_impl.c' -o 'ZZUGAS/lib/io_windows64_impl.o' -O2 -Wall -Wextra
& $gcc -c 'ZZUGAS/lib/io_windows64_wrappers.S' -o 'ZZUGAS/lib/io_windows64_wrappers.o' -Wall
& $ar rcs 'ZZUGAS/lib/io_windows64.a' 'ZZUGAS/lib/io_windows64_impl.o' 'ZZUGAS/lib/io_windows64_wrappers.o'
```

## 3. 在汇编程序中链接

示例（GAS Intel 语法 `.S`）：

```powershell
$gcc='C:\workspace\soft\msys2\mingw64\bin\gcc.exe'
& $gcc -o 'your_prog.exe' 'your_prog.S' 'ZZUGAS/lib/io_windows64.a'
```

## 4. 自动化测试文件

- 测试程序: `ZZUGAS/tests/io_windows64_test_all.S`
- 测试输入: `ZZUGAS/tests/io_windows64_test_input.txt`
- 期望输出: `ZZUGAS/tests/io_windows64_expected_output.txt`
- 实际输出: `ZZUGAS/tests/io_windows64_actual_output.txt`

执行命令：

```powershell
Set-Location 'c:\workspace\ZZUGAS'
$gcc='C:\workspace\soft\msys2\mingw64\bin\gcc.exe'

& $gcc -o 'ZZUGAS/tests/io_windows64_test_all.exe' 'ZZUGAS/tests/io_windows64_test_all.S' 'ZZUGAS/lib/io_windows64.a'
Get-Content 'ZZUGAS/tests/io_windows64_test_input.txt' | & '.\ZZUGAS\tests\io_windows64_test_all.exe' | Set-Content 'ZZUGAS/tests/io_windows64_actual_output.txt'
```

比对（忽略空行）：

```powershell
$expected = Get-Content 'ZZUGAS/tests/io_windows64_expected_output.txt' | Where-Object { $_ -ne '' }
$actual   = Get-Content 'ZZUGAS/tests/io_windows64_actual_output.txt'   | Where-Object { $_ -ne '' }
$expected.Count
$actual.Count
for ($i=0; $i -lt [Math]::Max($expected.Count,$actual.Count); $i++) {
  if ($expected[$i] -ne $actual[$i]) {
    "Mismatch line $($i+1): expected=[$($expected[$i])] actual=[$($actual[$i])]"
  }
}
```

当前结果：`EXPECTED_NONEMPTY=36`，`ACTUAL_NONEMPTY=36`，`ALL_TESTS_PASSED`。

## 5. 逐条功能测试结果

### 5.1 输出类函数

- `dispc`: 通过（`A`）
- `dispmsg`: 通过（`HelloOut`）
- `dispcrlf`: 通过（每条输出换行）
- `dispbb`: 通过（`10100101`）
- `dispbw`: 通过（`1010101111001101`）
- `dispbd`: 通过（`10101011110011011110111100000001`）
- `disphb`: 通过（`7F`）
- `disphw`: 通过（`7ABC`）
- `disphd`: 通过（`89ABCDEF`）
- `disphx`: 通过（`0123456789ABCDEF`）
- `dispuib`: 通过（`200`）
- `dispuiw`: 通过（`65535`）
- `dispuid`: 通过（`123456789`）
- `dispsib`: 通过（`-5`）
- `dispsiw`: 通过（`-12345`）
- `dispsid`: 通过（`-123456789`）
- `disprb`: 通过（`A5`）
- `disprw`: 通过（`ABCD`）
- `disprd`: 通过（`ABCDEF01`）
- `disprf`: 通过（`0000000000000202`）

### 5.2 输入类函数

- `readc`: 通过（输入 `Z...`，输出 `5A`）
- `readmsg`: 通过（输入 `HelloMsg`，输出 `HelloMsg`，长度 `8`）
- `readbb`: 通过（`10100101`）
- `readbw`: 通过（`1010101111001101`）
- `readbd`: 通过（`10101011110011011110111100000001`）
- `readhb`: 通过（`7f` -> `7F`）
- `readhw`: 通过（`7abc` -> `7ABC`）
- `readhd`: 通过（`89abcdef` -> `89ABCDEF`）
- `readuib`: 通过（`200`）
- `readuiw`: 通过（`65535`）
- `readuid`: 通过（`123456789`）
- `readsib`: 通过（`-5`）
- `readsiw`: 通过（`-12345`）
- `readsid`: 通过（`-123456789`）

## 6. 说明

- `readc` 使用 `getchar`，读取单字符；测试里采用第一行输入 `ZHelloMsg`，随后 `readmsg` 读取同一行剩余部分 `HelloMsg`。
- `dispcrlf` 输出 `\r\n`，在某些重定向场景会表现为空行分隔，因此比对时对空行做了归一化处理。
