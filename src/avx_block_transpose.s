.equ BLOCKSIZE, 8
.text
	.globl avx_block_transpose
	.type avx_block_transpose, @function

avx_block_transpose:
	pushl 	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%edi
	pushl	%ebx
	movl	8(%ebp), %esi	# esi = matrix
	movl	12(%ebp), %ebx	# ebx = row_stride

	vmovaps	(%esi), %ymm0
	vmovaps	32(%esi), %ymm1
	vmovaps	64(%esi), %ymm2
	vmovaps	96(%esi), %ymm3
	vmovaps	128(%esi), %ymm4
	vmovaps	160(%esi), %ymm5
	vmovaps	192(%esi), %ymm6
	vmovaps	224(%esi), %ymm7

	vunpcklps	%ymm1, %ymm0, %ymm8
	vunpckhps	%ymm1, %ymm0, %ymm0
	vunpcklps	%ymm3, %ymm2, %ymm9
	vunpckhps	%ymm3, %ymm2, %ymm2
	vunpcklps	%ymm5, %ymm4, %ymm10
	vunpckhps	%ymm5, %ymm4, %ymm4
	vunpcklps	%ymm7, %ymm6, %ymm11
	vunpckhps	%ymm7, %ymm6, %ymm6

	vunpcklps	%ymm9, %ymm8, %ymm12
	vunpckhps	%ymm9, %ymm8, %ymm8
	vunpcklps	%ymm11, %ymm10, %ymm13
	vunpckhps	%ymm11, %ymm10, %ymm10
	vunpcklps	%ymm6, %ymm4, %ymm14
	vunpckhps	%ymm6, %ymm4, %ymm4
	vunpcklps	%ymm2, %ymm0, %ymm15
	vunpckhps	%ymm2, %ymm0, %ymm0

	vperm2f128	$0x20, %ymm12, %ymm13, %ymm12
	vperm2f128	$0x31, %ymm12, %ymm13, %ymm13
	vperm2f128	$0x20, %ymm8, %ymm10, %ymm8
	vperm2f128	$0x31, %ymm8, %ymm10, %ymm10
	vperm2f128	$0x20, %ymm14, %ymm15, %ymm14
	vperm2f128	$0x31, %ymm14, %ymm15, %ymm15
	vperm2f128	$0x20, %ymm4, %ymm0, %ymm4
	vperm2f128	$0x31, %ymm4, %ymm0, %ymm0

	vmovaps	%ymm12, (%esi)
	vmovaps	%ymm8, 32(%esi)
	vmovaps	%ymm14, 64(%esi)
	vmovaps	%ymm4, 96(%esi)
	vmovaps	%ymm13, 128(%esi)
	vmovaps	%ymm10, 160(%esi)
	vmovaps	%ymm15, 192(%esi)
	vmovaps	%ymm0, 224(%esi)

	popl	%ebx
	popl	%edi
	popl	%esi
	popl	%ebp
	ret