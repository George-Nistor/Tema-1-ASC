//cerinta1
.data
	input: .space 1000
	current: .space 15
		
	identificator: .space 10
	identOp: .space 10
	indexCurrent: .space 10
	count: .long 0
	nrB10: .space 4
	p: .long 0
	
	strEmpty: .asciz ""
	strSpace: .asciz " "
	
	formatScanf: .asciz "%s"
	formatChart: .asciz "%c"
	formatPrintf: .asciz "%s"
	formatDec: .asciz "%d"
	
	let: .asciz "let"
	add: .asciz "add"
	sub: .asciz "sub"
	mul: .asciz "mul"
	div: .asciz "div"
.text

.global main

main:
	pushl $input 
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	movl $input, %edi
	movl $current, %esi
	xor %ecx, %ecx
et_for:
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je et_exit
	
	cmp $48, %al
	je cifra_0
	cmp $49, %al
	je cifra_1
	cmp $50, %al
	je cifra_2
	cmp $51, %al
	je cifra_3
	cmp $52, %al
	je cifra_4
	cmp $53, %al
	je cifra_5
	cmp $54, %al
	je cifra_6
	cmp $55, %al
	je cifra_7
	cmp $56, %al
	je cifra_8
	cmp $57, %al
	je cifra_9
	cmp $65, %al
	je cifra_A
	cmp $66, %al
	je cifra_B
	cmp $67, %al
	je cifra_C
	cmp $68, %al
	je cifra_D
	cmp $69, %al
	je cifra_E
	cmp $70, %al
	je cifra_F

counter:
	incl %ecx
	incl count
	cmp $3, count
	je resetCurrent
	jmp et_for
	
resetCurrent:
	pushl %ecx
	 
	pushl %edi
	pushl %esi
	
	movl $current, %edi
	movl $identificator, %esi
	mov $1, %ecx	
	movb (%edi, %ecx, 1), %bl
	mov $0, %ecx
	movb %bl, (%esi, %ecx, 1)
	mov $2, %ecx
	movb (%edi, %ecx, 1), %bl
	mov $1, %ecx
	movb %bl, (%esi, %ecx, 1)
	
	pushl $identificator
	call atoi
	popl %ebx
	
	popl %esi
	popl %edi
	
	cmp $0, %eax
	je currentNr
	cmp $1, %eax	
	je currentVar
	cmp $10, %eax
	je currentOp	
	
back_resetCurrent:
	// curent = ""
	pushl $strEmpty 
	pushl $current
	call strcpy
	popl %ebx
	popl %ebx

	// space
	pushl $strSpace 
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	popl %ecx #1
	
	movl $0, indexCurrent
	movl $0, count
	jmp et_for
	
currentNr:
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edi
	
	movl $0, nrB10
		
	movl $current, %edi
	movl $3, %ecx
	movb (%edi, %ecx, 1), %bl
	
	cmp $48, %bl # negative number
	je currentNr_b2TOb10
	
	push $45 # -
	push $formatChart
	call printf
	popl %ebx
	popl %ebx
	
	movl $4, %ecx
currentNr_b2TOb10:
	movb (%edi, %ecx, 1), %bl
	cmp $0, %bl
	je currentNr_b2TOb10_exit
	
	cmp $49, %bl
	je currentNr_b2TOb10_true
	
	incl %ecx		
	jmp currentNr_b2TOb10	
currentNr_b2TOb10_true:
	pushl %ecx

	movl $11, p
	movl $1, %eax
	sub %ecx, p
	mov p, %cl
	shl %cl, %eax
	add %eax, nrB10
	
	popl %ecx
	
	incl %ecx
	jmp currentNr_b2TOb10
currentNr_b2TOb10_exit:
	popl %edi
	popl %ecx
	popl %ebx
	popl %eax
	
	pushl nrB10
	pushl $formatDec
	call printf
	popl %ebx
	popl %ebx
	
	jmp back_resetCurrent
	
currentVar:
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edi
	
	movl $current, %edi
	movl $4, %ecx
	movl $0, nrB10
currentVar_b2TOb10:
	movb (%edi, %ecx, 1), %bl
	cmp $0, %bl
	je currentVar_b2TOb10_exit
	
	cmp $49, %bl
	je currentVar_b2TOb10_1
	
	incl %ecx		
	jmp currentVar_b2TOb10
currentVar_b2TOb10_1:
	pushl %ecx

	movl $11, p
	movl $1, %eax
	sub %ecx, p
	mov p, %cl
	shl %cl, %eax
	add %eax, nrB10
	
	popl %ecx
	
	incl %ecx
	jmp currentVar_b2TOb10
currentVar_b2TOb10_exit:
	popl %edi
	popl %ecx
	popl %ebx
	popl %eax
	
	pushl nrB10
	pushl $formatChart
	call printf
	popl %ebx
	popl %ebx
	jmp back_resetCurrent
	
currentOp:
	pushl %ecx 
	pushl %edi 
	pushl %esi 
	
	movl $current, %edi
	movl $identOp, %esi
	mov $9, %ecx	
	movb (%edi, %ecx, 1), %bl
	mov $0, %ecx
	movb %bl, (%esi, %ecx, 1)
	mov $10, %ecx
	movb (%edi, %ecx, 1), %bl
	mov $1, %ecx
	movb %bl, (%esi, %ecx, 1)
	mov $11, %ecx
	movb (%edi, %ecx, 1), %bl
	mov $2, %ecx
	movb %bl, (%esi, %ecx, 1)
	
	pushl $identOp
	call atoi
	popl %ebx
	
	cmp $0, %eax
	je currentOpLET
	cmp $1, %eax
	je currentOpADD
	cmp $10, %eax
	je currentOpSUB
	cmp $11, %eax
	je currentOpMUL
	cmp $100, %eax
	je currentOpDIV
back_currentOp:
	popl %esi
	popl %edi 
	popl %ecx 
	jmp back_resetCurrent
	
currentOpLET:
	push $let
	push $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	jmp back_currentOp
currentOpADD:
	push $add
	push $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	jmp back_currentOp
currentOpSUB:
	push $sub
	push $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	jmp back_currentOp
currentOpMUL:
	push $mul
	push $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	jmp back_currentOp
currentOpDIV:
	push $div
	push $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	jmp back_currentOp
cifra_0:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_1:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_2:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_3:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_4:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_5:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_6:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_7:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_8:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_9:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_A:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_B:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_C:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_D:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_E:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $48, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
cifra_F:
	pushl %ecx
	
	movl indexCurrent, %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	movb $49, (%esi, %ecx, 1)
	incl %ecx
	addl $4, indexCurrent
	
	popl %ecx
	jmp counter
et_exit:
	pushl $0
	call fflush
	popl %ebx
	
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
