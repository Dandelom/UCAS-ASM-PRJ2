.globl avx_dual_prefetch_transpose
.type avx_dual_prefetch_transpose, @function
avx_dual_prefetch_transpose:
	push	%rbp
	mov	%rsp, %rbp
	push	%rbx

	shl	$2, %rdx

	prefetcht0	(%rcx)
	leaq	(%rcx, %rdx, 4), %rax
	prefetcht0	(%rax)

	vmovups	(%rdi), %ymm0
	leaq	(%rdi, %rdx, 1), %rax
	vmovups	(%rax), %ymm1
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm2
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm3
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm4
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm5
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm6
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm7

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

	subq	$256, %rsp
	vmovups	%ymm8, (%rsp)
	vmovups	%ymm9, 32(%rsp)
	vmovups	%ymm10, 64(%rsp)
	vmovups	%ymm11, 96(%rsp)
	vmovups	%ymm12, 128(%rsp)
	vmovups	%ymm13, 160(%rsp)
	vmovups	%ymm14, 192(%rsp)
	vmovups	%ymm15, 224(%rsp)

	vmovups	(%rsi), %ymm0
	leaq	(%rsi, %rdx, 1), %rax
	vmovups	(%rax), %ymm1
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm2
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm3
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm4
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm5
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm6
	leaq	(%rax, %rdx, 1), %rax
	vmovups	(%rax), %ymm7

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
	
	# 改为使用 vmovups 写回 A 块
	vmovups	%ymm8, (%rdi)
	leaq	(%rdi, %rdx, 1), %rax
	vmovups	%ymm9, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm10, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm11, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm12, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm13, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm14, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm15, (%rax)

	vmovups	(%rsp), %ymm8
	vmovups	32(%rsp), %ymm9
	vmovups	64(%rsp), %ymm10
	vmovups	96(%rsp), %ymm11
	vmovups	128(%rsp), %ymm12
	vmovups	160(%rsp), %ymm13
	vmovups	192(%rsp), %ymm14
	vmovups	224(%rsp), %ymm15
	addq	$256, %rsp

	vmovups	%ymm8, (%rsi)
	leaq	(%rsi, %rdx, 1), %rax
	vmovups	%ymm9, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm10, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm11, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm12, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm13, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm14, (%rax)
	leaq	(%rax, %rdx, 1), %rax
	vmovups	%ymm15, (%rax)

	pop	%rbx
	mov	%rsp, %rbp
	pop	%rbp
	ret
