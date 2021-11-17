//cerinta4
.data
	v: .space 400 # => 4*100 = 400 elemente
	nrLin: .space 4
	nrCol: .space 4
	n: .space 4 # n = nrLin*nrCol
	elem: .space 4
	
	opNr: .space 4
	
	temp: .space 4
	sformatScanf: .asciz "%s"
	dformatScanf: .asciz "%d"
	dformatPrintf: .asciz "%d "
	
	sformatPrintf: .asciz "%s "
.text

.global main

main:
	pushl $temp # x
	pushl $sformatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $nrLin
	pushl $dformatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $nrCol
	pushl $dformatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	movl nrLin, %eax
	mull nrCol
	
	movl %eax, n
	
	xor %ecx, %ecx
	mov $v, %edi
for_input:
	cmp n, %ecx
	je exit_input
	
	pushl %ecx
	
	pushl $elem
	pushl $dformatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	popl %ecx
	
	movl elem, %eax
	movl %eax, (%edi, %ecx, 4)
	
	incl %ecx
	jmp for_input
exit_input:
	pushl $temp # let
	pushl $sformatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $temp # x
	pushl $sformatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $temp # opNr/rot90d
	pushl $sformatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $temp
	call atoi
	popl %ebx
	
	cmp $0, %eax
	je op_rot90d
	
	movl %eax, opNr
	
	pushl $temp #add/sub/mul/div
	pushl $sformatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	movl $temp, %esi
	xor %ecx, %ecx
	movb (%esi, %ecx, 1), %bl
	
	xor %ecx, %ecx
	mov $v, %edi
	
	cmp $97, %bl
	je op_add
	cmp $115, %bl
	je op_sub
	cmp $109, %bl
	je op_mul
	cmp $100, %bl
	je op_div
	
op_add:
	cmp n, %ecx
	je et_output
		
	movl (%edi, %ecx, 4), %eax
	add opNr, %eax
	movl  %eax, (%edi, %ecx, 4)
	
	incl %ecx
	jmp op_add
op_sub:
	cmp n, %ecx
	je et_output
		
	movl (%edi, %ecx, 4), %eax
	sub opNr, %eax
	movl  %eax, (%edi, %ecx, 4)
	
	incl %ecx
	jmp op_sub
op_mul:

op_div:

op_rot90d:

	jmp et_output
et_output:
	xor %ecx, %ecx
	mov $v, %edi
	
	pushl nrLin
	pushl $dformatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	pushl nrCol
	pushl $dformatPrintf
	call printf
	popl %ebx
	popl %ebx
	
for_output:
	cmp n, %ecx
	je et_exit
	
	movl (%edi, %ecx, 4), %eax
	
	pushl %ecx

	pushl %eax
	pushl $dformatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	popl %ecx
	
	incl %ecx
	jmp for_output
et_exit:
	pushl $0
	call fflush
	popl %ebx
	
	movl $1, %eax
	xor %ebx, %ebx
	int $0x80
