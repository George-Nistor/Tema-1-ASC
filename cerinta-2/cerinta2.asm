//cerinta2
.data
	x: .space 4
	y: .space 4
	res: .space 4
	
	str: .space 1000
	
	formatChart: .asciz "%c"
	formatDec: .asciz "%d"
	chDelim: .asciz " "
.text

.global main

main:
	pushl $str
	call gets
	popl %ebx
	
	pushl $chDelim
	pushl $str
	call strtok 
	popl %ebx
	popl %ebx
	
	pushl %eax
	call atoi
	popl %ebx
	
	pushl %eax
et_for:
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx 
	
	cmp $0, %eax
	je et_exit

	movl %eax, res	
	
	pushl %eax
	call atoi
	popl %ebx

	
	cmp $0, %eax
	jne et_numar
	
	movl res, %edi
	xor %ecx, %ecx
	movb (%edi, %ecx, 1), %bl
	
	cmp $97, %bl
	je op_add
	cmp $115, %bl
	je op_sub
	cmp $109, %bl
	je op_mul
	cmp $100, %bl
	je op_div
op_add:
	popl y
	popl x
	movl x, %eax
	add y, %eax
	pushl %eax
	jmp et_for
op_sub:
	popl y
	popl x
	movl x, %eax
	sub y, %eax
	pushl %eax
	jmp et_for
op_mul:
	popl y
	popl x
	movl x, %eax
	mull y
	pushl %eax
	jmp et_for
op_div:
	popl y
	popl x
	xor %edx, %edx
	movl x, %eax
	movl y, %ebx
	divl %ebx
	pushl %eax
	jmp et_for
et_numar:
	pushl %eax
	jmp et_for	
et_exit:
	popl %eax
	
	pushl %eax
	pushl $formatDec
	call printf
	popl %ebx
	popl %ebx
	
	push $10 # \n
	push $formatChart
	call printf
	popl %ebx
	popl %ebx

	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
