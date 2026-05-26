.globl avx_prefetch_transpose
.type avx_prefetch_transpose, @function
avx_prefetch_transpose:
	push	%rbp
	mov	%rsp, %rbp

	shl	$2, %rsi

	prefetcht0	(%rdx)
	leaq	(%rdx, %rsi, 2), %rax
	prefetcht0	(%rax)
	leaq	(%rax, %rsi, 2), %rax
	prefetcht0	(%rax)
	leaq	(%rax, %rsi, 2), %rax
	prefetcht0	(%rax)

	vmovups	(%rdi), %ymm0
	leaq	(%rdi, %rsi, 1), %rcx
	vmovups	(%rcx), %ymm1
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	(%rcx), %ymm2
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	(%rcx), %ymm3
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	(%rcx), %ymm4
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	(%rcx), %ymm5
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	(%rcx), %ymm6
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	(%rcx), %ymm7

	vunpcklps	%ymm1, %ymm0, %ymm8
	vunpckhps	%ymm1, %ymm0, %ymm9
	vunpcklps	%ymm3, %ymm2, %ymm10
	vunpckhps	%ymm3, %ymm2, %ymm11
	vunpcklps	%ymm5, %ymm4, %ymm12
	vunpckhps	%ymm5, %ymm4, %ymm13
	vunpcklps	%ymm7, %ymm6, %ymm14
	vunpckhps	%ymm7, %ymm6, %ymm15

	vshufps	$0x44, %ymm10, %ymm8, %ymm0
	vshufps	$0xEE, %ymm10, %ymm8, %ymm1
	vshufps	$0x44, %ymm11, %ymm9, %ymm2
	vshufps	$0xEE, %ymm11, %ymm9, %ymm3
	vshufps	$0x44, %ymm14, %ymm12, %ymm4
	vshufps	$0xEE, %ymm14, %ymm12, %ymm5
	vshufps	$0x44, %ymm15, %ymm13, %ymm6
	vshufps	$0xEE, %ymm15, %ymm13, %ymm7

	vperm2f128	$0x20, %ymm4, %ymm0, %ymm8
	vperm2f128	$0x20, %ymm5, %ymm1, %ymm9
	vperm2f128	$0x20, %ymm6, %ymm2, %ymm10
	vperm2f128	$0x20, %ymm7, %ymm3, %ymm11
	vperm2f128	$0x31, %ymm4, %ymm0, %ymm12
	vperm2f128	$0x31, %ymm5, %ymm1, %ymm13
	vperm2f128	$0x31, %ymm6, %ymm2, %ymm14
	vperm2f128	$0x31, %ymm7, %ymm3, %ymm15

	vmovups	%ymm8, (%rdi)
	leaq	(%rdi, %rsi, 1), %rcx
	vmovups	%ymm9, (%rcx)
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	%ymm10, (%rcx)
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	%ymm11, (%rcx)
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	%ymm12, (%rcx)
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	%ymm13, (%rcx)
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	%ymm14, (%rcx)
	leaq	(%rcx, %rsi, 1), %rcx
	vmovups	%ymm15, (%rcx)

	pop	%rbp
	ret
