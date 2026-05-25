.equ 	SIZE, 4096
.equ	BLOCKSIZE, 64
.text
	.globl off_diagonal_transpose
	.type off_diagonal_transpose, @function

off_diagonal_transpose:
	pushl 	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl	8(%ebp), %esi	# esi <= matrix1
	movl	12(%ebp), %ebx	# ebx <= matrix2

#	for(int i=0; i<BLOCKSIZE; i++)
#	{
#		for(int j=0; j<BLOCKSIZE; j++)
#		{
#			swap(matrix1[i][j], matrix2[j][i]);
#		}
#	}

	movl	$0, %edx	# edx <= i
L1:
	cmpl	$BLOCKSIZE, %edx
	jge	L3
	movl	$0, %ecx	# ecx <= j
L2:
	cmpl	$BLOCKSIZE, %ecx
	jge	Lplus
	imull	$SIZE, %edx, %eax
	addl	%ecx, %eax	# eax = i*SIZE+j
	leal	(%esi, %eax, 4), %edi	# edi = &matrix1[i][j]
	movss	(%edi), %xmm0
	imull	$SIZE, %ecx, %eax
	addl	%edx, %eax	# eax = j*SIZE+i
	movss	(%ebx, %eax, 4), %xmm1
	movss	%xmm1, (%edi)
	movss	%xmm0, (%ebx, %eax, 4)
	incl	%ecx
	jmp	L2
Lplus:
	incl	%edx
	jmp	L1
L3:
	popl	%edi
	popl	%esi
	popl	%ebx
	popl	%ebp
	ret
