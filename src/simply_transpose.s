.equ 	SIZE, 4096
.text
	.globl simply_transpose
	.type simply_transpose, @function

simply_transpose:
	pushl 	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl	8(%ebp), %esi	# esi <= matrix

#	for(int i=0; i<SIZE; i++)
#	{
#		for(int j=i+1; j<SIZE; j++)
#		{
#			swap(matrix[i][j], matrix[j][i]);
#		}
#	}

	movl	$0, %edx	# edx <= i
L1:
	cmpl	$SIZE, %edx
	jge	L3
	movl	%edx, %ecx
	incl	%ecx	# ecx <= j = i+1
L2:
	cmpl	$SIZE, %ecx
	jge	Lplus
	imull	$SIZE, %edx, %eax
	addl	%ecx, %eax	# eax = i*SIZE+j
	leal	(%esi, %eax, 4), %edi	# edi = &matrix[i][j]
	movss	(%edi), %xmm0
	imull	$SIZE, %ecx, %eax
	addl	%edx, %eax	# eax = j*SIZE+i
	movss	(%esi, %eax, 4), %xmm1
	movss	%xmm1, (%edi)
	movss	%xmm0, (%esi, %eax, 4)
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
