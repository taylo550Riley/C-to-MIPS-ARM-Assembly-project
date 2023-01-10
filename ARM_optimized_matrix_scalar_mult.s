// Riley Taylor
// Dr. Jamieson
// 4/28/22
// Advanced Assembly matrix scalar multiplication
// Using ARMv7 generic

//  -   -         --    --
// | 6 5 |       | 30  25 |
// | 4 3 | x 5 = | 20  15 |
// | 2 1 |       | 10   5 |
//  -   -         --    --	
	
	.global _start
_start:
	
	ldr r0, =row
	ldr r0, [r0]
	ldr r1, =col
	ldr r1, [r1]
	ldr r2, =scalar
	ldr r2, [r2]
	
	mov r3, #0		// int i
	mov r4, #0		// int j
	
	ldr r5, =scalar	// dynamic address
	add r5, r5, #8	// next word
	
	ldr r6, =array1	// starting address of m
	
	mov r8, #0
	mov r9, #0
	mov r10, #0
	mov r11, #4		// r11 to have a constant
	
	b for_i
	
for_i:
	mov r4, #0		// j = 0
	cmp r3, r1		// i < col
	blt for_j
	b EXIT
	
	for_j:
		cmp r4, r0			// j < row
		blt matrix_builder	
		add r3, r3, #1		// i++
		b for_i
		
		matrix_builder:
			mul r8, r3, r11	// r8 = i * 4
			mul r9, r1, r11	// row calculation is weighted by col
			mul r10, r9, r4	// r10 = j * weighted row calculation
			add r6, r6, r8	// address addition m[i]
			add r6, r6, r10	// address addition m[j]
			ldr r7, [r6]
			mul r12, r7, r2	// m[i][j] * scalar
			add r4, r4, #1	// j++
			ldr r6, =array1	// reload starting address of m
			str r12, [r5]	// store r_m[i][j] = m[i][j] * scalar
			add r5, r5, #4	// next word in dynamic
			b for_j
EXIT:
	pop {pc}
	
.data
	array1:		.word	3, 4
	array2:		.word	-1, 0
	array3:		.word	-3, 7
	array4:
	array5:
	array6:
	array7:
	array8:
	array9:
	array10:
	array11:
	array12:	
	array13:
	array14:
	array15:
	
	row:		.word	3
	col:		.word	2
	scalar:		.word	-7