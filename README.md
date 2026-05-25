# UCAS-ASM-PRJ2
国科大2026年春季学期汇编语言大作业2

## 任务要求
> 实现单精度浮点的矩阵（4096*4096）转置程序，给出C代码和相应的汇编代码，并测试不同算法（关键核心函数使用汇编代码）的时间和加速比。
> 1. 简单转置
> 2. 分块转置（64*64）
> 3. 4x4 SIMD 转置
> 4. 8x8 AVX 转置
> 5. AVX + Blocking + Prefetch ...
>
> 小组完成，人数小于等于三个人，至少采用四种优化方法，提交源代码和实验报告，报告一定要写明小组成员。

## 规范
项目开发环境为 Linux，采用 **x86-32，AT&T** 语法规范，浮点数处理采用更为现代的 **SSE2 指令集**。只提交 C 语言代码和汇编代码，忽略可执行文件或 .o 文件等，具体规则可配置 .gitignore 文件。

代码存放在 src 文件夹，测试数据存放在 tests 文件夹，实验报告存放在 docs 文件夹。

算法时间、加速比统一在实验报告里讨论。

其他细节详见 docs 文件夹下的项目说明文档。

**记得写好commit。**

## To-Do List & 分工
- [x] 主函数 by WJC
- [x] 简单转置 by WJC
- [x] 分块转置 by ZCX
- [x] 4×4 SIMD 转置 by HYH
- [x] 8×8 AVX 转置 by HYH

## 更新说明

### 4×4 SIMD 转置（HYH）
- 使用 SSE2 指令集实现 4×4 块转置
- 采用连续块拷贝法处理内存布局问题
- C 包装函数负责块间交换逻辑，汇编函数处理连续块内转置
- 关键文件：`simd_transpose.c`、`simd_block_transpose.s`
- 技术细节：`movaps` + `unpcklps/unpckhps` + `movlhps/movhlps` 实现 4×4 矩阵转置
- 遵循 System V AMD64 ABI：仅使用 xmm0-xmm7（调用者保存寄存器）

### 8×8 AVX 转置（HYH）
- 使用 AVX 指令集实现 8×8 块转置
- 同样采用连续块拷贝法处理非连续内存访问
- C 包装函数负责块间交换逻辑，汇编函数处理连续块内转置
- 关键文件：`avx_transpose.c`、`avx_block_transpose.s`
- 技术细节：`vmovups` + `vunpcklps/vunpckhps` + `vshufps` + `vperm2f128` 实现 8×8 矩阵转置
- 完整的转置算法分为三个步骤：
  1. 2x2转置（解交织行对）
  2. 4x4转置（vshufps $0x44/$0xEE）
  3. 8x8转置（vperm2f128交换高低128位）
- 严格遵循 System V AMD64 ABI：
  - 保存 ymm8-ymm15（被调用者保存寄存器）
  - 栈对齐到32字节（and $-32, %rsp）
  - 函数返回前恢复所有寄存器

### 调试经历与修复要点
1. **32位到64位迁移**：从x86-32转换为x86-64，使用System V ABI
2. **内存布局问题**：使用连续块拷贝法解决非连续访问问题
3. **SIMD寄存器保存**：ymm8-ymm15是被调用者保存的，必须在函数内保存和恢复
4. **AVX转置算法**：完整的三步转置算法，确保8x8矩阵完全正确转置

### 测试程序
- 新增 `test_simd_avx.c` 用于单独测试 64 位版本的 SIMD 和 AVX 转置
- 支持 64 位编译模式（`-m64`）
- 使用 `-O3` 优化级别提升性能
- 通过 `check.c` 验证转置结果正确性

### 完整测试命令
```bash
cd /mnt/c/Users/15861/Desktop/大二下学习/大二下各科作业/汇编语言/汇编大作业二/UCAS-ASM-PRJ2/src

# 编译所有程序
gcc -o test_simd_avx test_simd_avx.c simd_transpose.c simd_block_transpose.s avx_transpose.c avx_block_transpose.s -m64 -O3 -mavx -msse2
gcc -o generate generate.c -m64
gcc -o check check.c -m64

# 测试SIMD转置
./generate
./test_simd_avx
# 输入：3
./check

# 测试AVX转置
./generate
./test_simd_avx
# 输入：4
./check
```