//cerinta4
.data

.text

.global main

main:

et_exit:
	mov $1, %eax
	xor %ebx, %ebx
	int $0x08
