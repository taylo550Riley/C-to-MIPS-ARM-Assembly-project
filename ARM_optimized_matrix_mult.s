// Riley Taylor
// Dr. Jamieson
// 4/28/22
// Advanced Assembly matrix multiplication
// Using ARMv7 generic

//  -   -     --     --     -          -
// | 6 5 |   | 7 9  11 |   | 82 104 126 |
// | 4 3 | x | 8 10 12 | = | 52  66  80 |
// | 2 1 |    --     --    | 22  28  34 |
//  -   -                   -          -

.global _start
_start:
	mov r0, #0		// int i = 0
	mov r1, #0		// int j = 0
	mov r2, #0		// int k = 0
	ldr r3, =mrow	// loads r3 with mrow address
	ldr r3, [r3]	// loads r3 with mrow value
	ldr r4, =mcol	// loads r4 with mcol address
	ldr r4, [r4]	// loads r4 with mcol value
	ldr r5, =nrow	// loads r5 with nrow address
	ldr r5, [r5]	// loads r5 with nrow value
	ldr r6, =ncol	// loads r6 with ncol address
	ldr r6, [r6]	// loads r6 with ncol value
	
	cmp r5, r4		// if (nrow != mcol) return r_m (exit)
	bne EXIT
	
	ldr r7, =array1	// starting address of m
	ldr r8, =array8	// starting address of n
	
	mov r9, #0		// lw $s5, ($t3)	// ldr r9, [r7]
					// r7 == t3
	mov r10, #0		// lw $s6, ($t4)	// ldr r10, [r8]
	
	// r11 temp #4 to use in first part of matrix builder
	mov r11, #4		// add t5, s5, s6	// sw t5, (t9)	// r11 == t5 == m[k][j]*n[i][k]
	
	ldr r12, =ncol		// global pointer
	add r12, r12, #40	// point to 'heap'
	
	mov r13, #0

	b for_i
	
	b EXIT

	
	for_i:
		ldr r6, =ncol	// loads r6 with ncol address
		ldr r6, [r6]	// loads r6 with ncol value
		mov r1, #0		// j = 0
		cmp r0, r6		// i < ncol
		blt for_j
		b EXIT
		
		for_j:
			ldr r3, =mrow			// loads r3 with mrow address
			ldr r3, [r3]			// loads r3 with mrow value
			mov r2, #0				// k = 0
			cmp r1, r3				// j < mrow
			blt for_k
			add r0, r0, #1			// i++
			b for_i
			
			for_k:
				ldr r4, =mcol		// loads r6 with ncol address
				ldr r4, [r4]		// loads r6 with ncol value
				ldr r5, =nrow		// loads r5 with nrow address
				ldr r5, [r5]		// loads r5 with nrow value
				cmp r2, r5			// k < nrow
				blt matrix_builder
				str r13, [r12]		// r_m[i][j] = m[k][j] * n[i][k]
				mov r13, #0			// r_m[i][j] = 0
				ldr r3, =mrow		// loads r3 with mrow address
				ldr r3, [r3]		// loads r3 with mrow value
				mov r9, #0
				mov r10, #0
					
				add r12, r12, r11	// point to next word in dynamic memory
				add r1, r1, #1		// j++
				b for_j

	matrix_builder:
						
			//////////////////////
			/////// m[k][j] //////
			//////////////////////
						
		// first need mcol to stay on r4 for now
		mov r3, #0			// reset mrow to use later
		mov r5, #0			// reset nrow to use later
		mov r6, #0			// reset ncol to use later

		// r3 == t8
		// r5 == a1
		// r6 == t7

		mul r3, r2, r11		// r3 = k * 4
		mul r5, r4, r11		// row calculation is weighted by mcol
		mul r6, r1, r5		// r6 = j * weighted value

		add r7, r7, r6		// address addition m[k]
		add r7, r7, r3		// address addition m[j]
		ldr r9, [r7]		// load r9 with r7 address value

		ldr r6, =ncol		// loads r6 with ncol address
		ldr r6, [r6]		// loads r6 with ncol value
		/////////////////////////////////////////////////////////////


				//////////////////////
				////// n[i][k] ///////
				//////////////////////

		mov r3, #0			// reset mrow to use later
		mov r4, #0			// reset mcol to use later
		mov r5, #0			// reset nrow to use later

		// r3 == t6
		// r4 == a2
		// r5 == t8

		mul r3, r0, r11		// r3 = i * 4
		mul r4, r6, r11		// row calculation is weighted by ncol
		mul r5, r2, r4		// r5 = k * weighted value

		add r8, r8, r3		// address addition n[i]
		add r8, r8, r5		// address addition n[k]
		ldr r10, [r8]		// load r10 with r8 address value

		/////////////////////////////////////////////////////////////

		mov r3, #0			// reset mrow to use later
		mov r4, #0			// reset mcol to use later

		// r3 == s7
		// r13 == t5

		mul r3, r9, r10		// m[k][j] * n[i][k]
		add r13, r13, r3	// r_m = m[k][j] * n[i][k]


		ldr r7, =array1		// starting address of m
		ldr r8, =array8		// starting address of n
		add r2, r2, #1
		b for_k
						
EXIT:
	pop {pc}				// exit program
	
.data
	array1:		.word	1, 1, 1, -1
	array2:		.word	2, 0, -3, 4
	array3:		//.word	5, 1
	array4:		//.word	-4, 3
	array5:
	array6:
	array7:
	array8:		.word	3, 1
	array9:		.word	-4, 1
	array10:	.word	5, 1
	array11:	.word	-4, 3
	array12:	
	array13:
	array14:
	array15:
	
	mrow:	.word	2
	mcol:	.word	4
	nrow:	.word	4
	ncol:	.word	2