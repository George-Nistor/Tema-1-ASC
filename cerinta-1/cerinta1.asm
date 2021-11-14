//cerinta1
.data
	input: .space 100
	formatScanf: .asciz "%s"
	formatPrintf: .asciz "Sirul citit este %s.\n"
.text

.global main

main:
	//scanf("%s", &input)
	pushl $input 
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	//printf("Sirul este %s\n", x);
	pushl $input
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	

et_exit:
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
