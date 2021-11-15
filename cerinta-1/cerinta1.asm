//cerinta1
.data
	input: .space 100
	current: .space 12
	
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
	
	
	identificator: .space 3
	identificator_var: .space 10
	identificator_op: .long 0
	indexCurrent: .long 0
	count: .long 0
	nrB10: .long 0
	p: .long 0
.text

.global main

main:
	//scanf("%s", &input)
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

et_counter:
	incl %ecx
	incl count
	cmp $3, count
	je et_resetCurrent
	jmp et_for
	
et_resetCurrent:
	pushl %ecx #1
	
	pushl %edi #2
	pushl %esi #3
	
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
	
	popl %esi #3
	popl %edi #2
	
	cmp $0, %eax
	je currentNr
	cmp $1, %eax	
	je currentVar
	cmp $10, %eax
	je currentOp	
	
back_resetCurrent:
	pushl $strEmpty
	pushl $current
	call strcpy
	popl %ebx
	popl %ebx


	//SPACE
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
	
	cmp $48, %bl
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
et_b2TOb10:
	movb (%edi, %ecx, 1), %bl
	cmp $0, %bl
	je exit_b2TOb10
	
	cmp $49, %bl
	je true_b2TOb10
	
	incl %ecx		
	jmp et_b2TOb10
true_b2TOb10:
	pushl %ecx

	movl $11, p
	movl $1, %eax
	sub %ecx, p
	mov p, %cl
	shl %cl, %eax
	add %eax, nrB10
	
	popl %ecx
	
	incl %ecx
	jmp et_b2TOb10
exit_b2TOb10:
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
	pushl %ecx #1
	pushl %edi #2
	pushl %esi #3
	
	movl $current, %edi
	movl $identificator_op, %esi
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
	
	pushl $identificator_op
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
	popl %esi #3
	popl %edi #2
	popl %ecx #1
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
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
	jmp et_counter
et_exit:
	pushl $0
	call fflush
	popl %ebx
	
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80

