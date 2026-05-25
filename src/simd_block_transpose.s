.equ BLOCKSIZE, 4
.text
	.globl simd_block_transpose
	.type simd_block_transpose, @function

simd_block_transpose:
	pushl 	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%edi
	pushl	%ebx
	movl	8(%ebp), %esi	# esi = matrix
	movl	12(%ebp), %ebx	# ebx = row_stride

	movaps	(%esi), %xmm0
	movaps	16(%esi), %xmm1
	movaps	32(%esi), %xmm2
	movaps	48(%esi), %xmm3

	movaps	%xmm0, %xmm4
	shufps	$0x4E, %xmm1, %xmm4
	movaps	%xmm2, %xmm5
	shufps	$0x4E, %xmm3, %xmm5

	movaps	%xmm0, %xmm6
	shufps	$0x91, %xmm1, %xmm6
	movaps	%xmm2, %xmm7
	shufps	$0x91, %xmm3, %xmm7

	movaps	%xmm4, %xmm0
	shufps	$0x39, %xmm5, %xmm0
	movaps	%xmm6, %xmm1
	shufps	$0x39, %xmm7, %xmm1
	movaps	%xmm4, %xmm2
	shufps	$0x39, %xmm5, %xmm2
	movaps	%xmm6, %xmm3
	shufps	$0x39, %xmm7, %xmm3

	shufps	$0x01, %xmm1, %xmm0
	shufps	$0x01, %xmm3, %xmm2

	movaps	%xmm0, (%esi)
	movaps	%xmm1, 16(%esi)
	movaps	%xmm2, 32(%esi)
	movaps	%xmm3, 48(%esi)

	popl	%ebx
	popl	%edi
	popl	%esi
	popl	%ebp
	ret