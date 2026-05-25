.globl avx_block_transpose
.type avx_block_transpose, @function
avx_block_transpose:
	push	%rbp
	mov	%rsp, %rbp
	and	$-32, %rsp
	sub	$256, %rsp

	vmovups	%ymm8, (%rsp)
	vmovups	%ymm9, 32(%rsp)
	vmovups	%ymm10, 64(%rsp)
	vmovups	%ymm11, 96(%rsp)
	vmovups	%ymm12, 128(%rsp)
	vmovups	%ymm13, 160(%rsp)
	vmovups	%ymm14, 192(%rsp)
	vmovups	%ymm15, 224(%rsp)

	vmovups	(%rdi), %ymm0
	vmovups	32(%rdi), %ymm1
	vmovups	64(%rdi), %ymm2
	vmovups	96(%rdi), %ymm3
	vmovups	128(%rdi), %ymm4
	vmovups	160(%rdi), %ymm5
	vmovups	192(%rdi), %ymm6
	vmovups	224(%rdi), %ymm7

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
	vmovups	%ymm9, 32(%rdi)
	vmovups	%ymm10, 64(%rdi)
	vmovups	%ymm11, 96(%rdi)
	vmovups	%ymm12, 128(%rdi)
	vmovups	%ymm13, 160(%rdi)
	vmovups	%ymm14, 192(%rdi)
	vmovups	%ymm15, 224(%rdi)

	vmovups	(%rsp), %ymm8
	vmovups	32(%rsp), %ymm9
	vmovups	64(%rsp), %ymm10
	vmovups	96(%rsp), %ymm11
	vmovups	128(%rsp), %ymm12
	vmovups	160(%rsp), %ymm13
	vmovups	192(%rsp), %ymm14
	vmovups	224(%rsp), %ymm15

	leave
	ret