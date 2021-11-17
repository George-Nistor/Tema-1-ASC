//cerinta4
.data
	n: .space 4
	v: .space 400 # => 4*100 = 400 elemente
	elem: .space 4
	formatScanf: .asciz "%d"
	formatPrintf: .asciz "%d "
.text

.global main

main:
	pushl $n
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	xor %ecx, %ecx
	mov $v, %edi
for_input:
	cmp n, %ecx
	je exit_input
	
	pushl %ecx
	
	pushl $elem
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	popl %ecx
	
	movl elem, %eax
	movl %eax, (%edi, %ecx, 4)
	
	incl %ecx
	jmp for_input
exit_input:
	xor %ecx, %ecx
	mov $v, %edi 
for_output:
	cmp n, %ecx
	je et_exit
	
	movl (%edi, %ecx, 4), %eax
	
	pushl %ecx
	
	pushl %eax
	pushl $formatPrintf
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
