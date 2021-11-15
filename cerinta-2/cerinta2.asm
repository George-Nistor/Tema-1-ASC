//cerinta2
.data
	str: .space 100
	formatPrintf: .asciz "%d"
.text

.global main

main:
	pushl $str
	call gets
	popl %ebx
et_exit:
	pushl $0
	call fflush
	popl %ebx

	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
