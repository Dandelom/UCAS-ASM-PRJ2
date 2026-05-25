.globl simd_block_transpose
.type simd_block_transpose, @function
simd_block_transpose:
	push	%rbp
	mov	%rsp, %rbp

	movaps	(%rdi), %xmm0
	movaps	16(%rdi), %xmm1
	movaps	32(%rdi), %xmm2
	movaps	48(%rdi), %xmm3

	movaps	%xmm0, %xmm4
	unpcklps	%xmm1, %xmm0
	unpckhps	%xmm1, %xmm4
	movaps	%xmm2, %xmm5
	unpcklps	%xmm3, %xmm2
	unpckhps	%xmm3, %xmm5

	movaps	%xmm0, %xmm1
	movlhps	%xmm2, %xmm0
	movhlps	%xmm1, %xmm2
	movaps	%xmm4, %xmm3
	movlhps	%xmm5, %xmm4
	movhlps	%xmm3, %xmm5

	movaps	%xmm0, (%rdi)
	movaps	%xmm2, 16(%rdi)
	movaps	%xmm4, 32(%rdi)
	movaps	%xmm5, 48(%rdi)

	pop	%rbp
	ret