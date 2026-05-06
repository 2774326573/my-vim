# GDB 调试手册

> **GDB**（GNU Debugger）是 GNU 项目下的命令行调试器，支持 C、C++、Go 等语言。  
> 本手册面向日常开发，侧重常用命令与实战场景，便于快速查阅。

---

## 一、快速上手

### 1.1 编译带调试信息的程序

调试前必须让编译器生成**符号表**（-g），否则 GDB 无法对应源码行号。

```bash
# C/C++ 推荐（-g 调试信息，-O0 关闭优化便于调试）
gcc -g -O0 -o myapp main.c
g++ -g -O0 -o myapp main.cpp
```

> **提示**：发布版本不要带 `-g`，否则可执行文件会变大且易被反编译。

### 1.2 启动与退出

```bash
gdb ./myapp          # 调试 myapp
gdb ./myapp 1234     # 调试 myapp，并 attach 到进程 1234
gdb -q ./myapp       # -q 安静模式，少打印版本信息

# 在 GDB 内
quit   # 或 q    退出
```

---

## 二、断点与运行控制

### 2.1 设断点

| 命令 | 简写 | 说明 |
|------|------|------|
| `break 行号` | `b 行号` | 当前文件某行设断点 |
| `break 文件:行号` | `b 文件:行号` | 指定文件某行 |
| `break 函数名` | `b 函数名` | 函数入口断点 |
| `break 文件:函数名` | — | 指定文件的某函数 |
| `break *地址` | — | 按地址断点（底层调试） |

**条件断点**（某条件成立时才停）：

```text
break 10 if i == 5
break foo if ptr != 0
```

**临时断点**（命中一次后自动删除）：

```text
tbreak 15
tbreak main
```

### 2.2 查看 / 删除 / 禁用断点

```text
info breakpoints   # 或 i b    列出所有断点
delete 1           # 或 d 1    删除 1 号断点
delete             # 删除全部断点
disable 1          # 禁用 1 号断点（不删除）
enable 1           # 重新启用 1 号断点
```

### 2.3 运行与单步

| 命令 | 简写 | 说明 |
|------|------|------|
| `run [参数]` | `r` | 从头运行程序，可带命令行参数 |
| `continue` | `c` | 继续运行到下一断点 |
| `next` | `n` | 单步**越过**（不进入函数） |
| `step` | `s` | 单步**进入**函数 |
| `finish` | `fin` | 运行到当前函数返回 |
| `until 行号` | `u 行号` | 运行到某行（常用于跳出循环） |

---

## 三、查看数据

### 3.1 打印变量与表达式

```text
print 变量名        # 或 p 变量名
print ptr->member
print *ptr
print array[0]
print i + 1
```

**格式化输出**（`p/格式 变量`）：

| 格式 | 含义 | 示例 |
|------|------|------|
| `x` | 十六进制 | `p/x ptr` |
| `d` | 有符号十进制 | `p/d x` |
| `u` | 无符号十进制 | `p/u x` |
| `c` | 字符 | `p/c c` |
| `s` | 字符串 | `p/s str` |
| `a` | 地址 | `p/a ptr` |

**自动显示**（每次停住都打印）：

```text
display 变量名      # 每次停住自动打印
display/i $pc       # 自动反汇编当前指令
undisplay 编号      # 取消 display
info display        # 查看所有 display
```

### 3.2 查看内存

```text
x/数量格式 地址
# 数量：要显示的单元个数
# 格式：b(字节) h(半字) w(字) g(八字)；x(十六进制) d(十进制) s(字符串) i(指令)

x/10xb ptr         # 从 ptr 起 10 个字节，十六进制
x/s 0x地址         # 把该地址当字符串显示
x/20xw 数组名      # 20 个字，十六进制（看数组内容）
```

### 3.3 查看源码与栈

```text
list               # 或 l      当前行附近源码
list 行号          # 某行附近
list 函数名        # 某函数
list 文件:行号     # 指定文件

backtrace          # 或 bt     当前调用栈
frame 层号         # 或 f 层号 切换到某层栈帧
info locals        # 当前栈帧局部变量
info args          # 当前函数参数
```

---

## 四、多线程 / 多进程

### 4.1 线程

```text
info threads       # 列出所有线程
thread 2           # 切换到 2 号线程
break 文件:行号 thread 2   # 仅在 2 号线程该行断点
```

### 4.2 多进程（fork）

```text
set follow-fork-mode parent   # 只跟父进程（默认）
set follow-fork-mode child    # 只跟子进程
set detach-on-fork off        # fork 后两个都跟，需手动切换
info inferiors                # 查看进程
inferior 2                    # 切换到 2 号进程
```

---

## 五、常用技巧

### 5.1 程序已运行：挂接（attach）

```bash
# 先查到进程 PID
ps aux | grep myapp

# 再 attach
gdb -p 1234
# 或在 gdb 内：attach 1234
```

> 需有相应权限（如 root 或同一用户）。  
> 若程序未带 `-g` 编译，只能看汇编和少量符号。

### 5.2  core  dump 事后分析

```bash
# 先让系统能生成 core（示例：Linux）
ulimit -c unlimited

# 程序崩溃后会生成 core
gdb ./myapp core
# 进入后直接 bt 看崩溃时的调用栈
(gdb) bt
(gdb) frame 0
(gdb) info locals
```

### 5.3 日志与命令脚本

```text
# 把本次调试输出记到文件
set logging file gdb.log
set logging on
# ... 调试 ...
set logging off

# 从文件读入命令（相当于脚本）
source my.gdb
```

**示例 `my.gdb`**：

```text
break main
run
break foo
continue
bt
quit
```

### 5.4 常用设置

```text
set print pretty on        # 结构体格式化打印
set print array on         # 数组整体打印
set pagination off         # 输出不分页（脚本友好）
set confirm off            # 退出不确认
```

---

## 六、CMake + GDB

用 **CMake** 构建时，只要让 CMake 生成**带调试信息的构建**，再用 GDB 调试生成的可执行文件即可。

### 6.1 构建类型（必知）

| 构建类型 | 说明 | 调试 |
|----------|------|------|
| **Debug** | `-g`，无优化或 -O0 | ✅ 适合日常单步、断点 |
| **RelWithDebInfo** | `-g` + -O2 | ✅ 性能接近发布，仍有符号，适合复现性能问题 |
| **Release** | 无 `-g`，-O3 | ❌ 难以调试 |
| **MinSizeRel** | 无 `-g`，偏体积优化 | ❌ 一般不用于调试 |

**单配置生成器**（Ninja、Unix Makefiles 等）：在**配置阶段**指定类型：

```bash
# 推荐：Debug 便于调试
cmake -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build
```

**多配置生成器**（Visual Studio、Xcode）：在**编译阶段**选配置：

```bash
cmake -B build -G "Visual Studio 17 2022" -A x64
cmake --build build --config Debug
```

若 `CMakeLists.txt` 里已写 `set(CMAKE_BUILD_TYPE Debug)`，则单配置生成器可省略 `-DCMAKE_BUILD_TYPE=Debug`（未指定时部分平台会无默认类型，建议显式写）。

### 6.2 配置 + 编译 + 用 GDB 调试

```bash
# 1. 配置（Debug）
cmake -B build -DCMAKE_BUILD_TYPE=Debug

# 2. 编译
cmake --build build

# 3. 可执行文件一般在 build/ 下（名字以 CMakeLists 里 add_executable 为准）
# Linux/macOS 示例：
gdb build/mathdemo

# Windows 示例（MinGW/Cygwin 下 GDB）：
gdb build/mathdemo.exe
```

在 GDB 里照常使用 `run`、`break`、`next`、`print` 等（见本手册二、三节）。

### 6.3 传参、工作目录

程序要带参数或改工作目录时，在 GDB 里：

```text
(gdb) set args --input data.txt
(gdb) run
```

或直接：

```text
(gdb) run --input data.txt
```

工作目录可在运行前用 shell 切到项目根再启动 GDB，或 CMake 用 `add_test`/脚本在指定目录下跑。

### 6.4 与 Vimspector 配合

本仓库 `.vimspector.json` 里 C/C++ 的 `program` 写的是 `${workspaceRoot}/a.out`。若改用 **CMake 生成的可执行文件**，可改为（按你实际路径和名字改）：

- `${workspaceRoot}/build/mathdemo`（或 `build/mathdemo.exe`）

并确保用 **Debug** 构建，这样 Vimspector 调用的 GDB 才能正确对应源码。

---

## 七、与 Vim / 本仓库的配合

本仓库的 `.vimspector.json` 中 C/C++ 使用 **MIMode: gdb**，即底层用 GDB 做调试。

- 在 **Vim / Neovim** 里用 Vimspector 时，断点、单步、查看变量会由 Vimspector 转成 GDB 命令。
- 直接在终端用 **GDB** 时，可按本手册命令操作；两者概念一致，只是操作方式不同（GUI/按键 vs 命令行）。

**建议**：

1. 本地开发：用 `-g -O0` 编译，再用 GDB 或 Vimspector 调试。
2. 线上/core 分析：用 `gdb ./程序 core` 或 `gdb -p PID`，先 `bt` 再 `frame` + `info locals` 定位问题。

---

## 八、命令速查表

| 分类 | 命令 | 简写 |
|------|------|------|
| 断点 | break / tbreak / delete / disable / enable | b / tb / d / dis / en |
| 运行 | run / continue / next / step / finish | r / c / n / s / fin |
| 查看 | print / backtrace / list / info locals | p / bt / l / i lo |
| 栈 | frame / up / down | f / u / d |
| 内存 | x | — |
| 线程 | info threads / thread | i th / th |
| 其他 | quit / set / display | q / set / disp |

---

*文档维护：my-vim 仓库 · 供日常 GDB 调试查阅。*
