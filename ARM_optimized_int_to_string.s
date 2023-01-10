// Riley Taylor
// Dr. Jamieson
// 4/2/22
// Advanced Assembly int to string
// Using ARMv7 generic

.global _start
_start:
	
	ldr r12, =num_bits
	ldr r0, [r12]		// r0 = num_bits
	ldr r12, =orig_long
	ldr r1, [r12]		// r1 = orig_long
	ldr r12, =one
	ldrb r3, [r12] 		// r3 = '1'
	ldr r12, =zero
	ldrb r4, [r12]		// r4 = '0'
	mov r6, #0
	
	mov r2, #0		// i = 0
	sub r2, r0, #1	// i = num_bits - 1
	mov r5, #1		// mask = 1

	bl for_i
	
	b EXIT
	
for_i:
	cmp r2, #0
	beq jumpReturn
	and r6, r1, r5		// mask & orig_long
	cmp r6, #0
	bgt if_success
	// else {
	strb r4, [r12]		// store a '0' in memory
	sub r12, r12, #1	// point to next (previous) bit in dynamic memory
	lsl r5, r5, #1		// mask = mask << 1
	sub r2, r2, #1		// i--
	b for_i
	
	
	if_success:
		strb r3, [r12]		// store '1' in dynamic
		sub r12, r12, #1	// point to next (previous) bit in dynamic memory
		lsl r5, r5, #1		// mask = mask << 1
		sub r2, r2, #1		// i--
		b for_i
	
jumpReturn:
	bx lr
	
EXIT:
	pop {pc}
	
.data
	num_bits:	.word	32	// max for long long is 64
	orig_long:	.word	-154
	one:		.byte	'1'
	zero:		.byte	'0'
	null:		.byte	'0'	// 0 acts as the null terminator