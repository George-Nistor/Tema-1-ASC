//cerinta3
.data
	x: .space 4
	y: .space 4
	poz: .space 4
	var: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	
	str: .space 1000
	res: .space 4
	
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
	
	movl %eax, res
	
	pushl %eax
	call atoi
	popl %ebx
	
	cmp $0, %eax
	je et_var
	
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
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	cmp $0, %al
	je et_var
	
	cmp $97, %bl
	je op_add
	cmp $115, %bl
	je op_sub
	cmp $109, %bl
	je op_mul
	cmp $100, %bl
	je op_div
	cmp $108, %bl
	je op_let
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
op_let:
	popl y
	popl x
	movl y, %ebx
	movl x, %ecx
	movl %ebx, (%esi, %ecx, 4)
	 
	jmp et_for
et_numar:
	pushl %eax
	jmp et_for
et_var:
	movl res, %edi
	xor %ecx, %ecx
	movb (%edi, %ecx, 1), %bl
	
	mov %bl, poz
	sub $97, poz
	
	movl $var, %esi
	movl poz, %ecx
	movl (%esi, %ecx, 4), %ebx
		
	cmp $0, %ebx
	jne et_varExist
	
	pushl poz
	jmp et_for
et_varExist:
	pushl (%esi, %ecx, 4)
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
