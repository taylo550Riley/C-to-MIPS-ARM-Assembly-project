// Riley Taylor
// Dr. Jamieson
// 3/19/22
// Advanced Assembly Bubble Sort
// Bubble Sort best-O(n) avg-O(n2) worst-O(n2)
// Bubble sort for an integer array
// Using ARMv7 generic

.global _start
_start:
	
	mov r0, #0			// int i = 0
	mov r1, #0			// int j = 0
	mov r2, #12			// array size
	mov r5, #0
	mov r12, #4
	sub r2, r2, #1
	ldr r3, =a			// loads address of a in r3
	
	b for_i
	
for_i:
	cmp r0, r2			// i < size - 1 (?)
	blt for_j
	b EXIT
	
	for_j:
		ldr r3, =a		// reset memory pointer
		sub r4, r2, r0	// r4 = size - 1 - i
		mul r5, r1, r12	// r5 = j * 4
		add r3, r3, r5	// r3 points to a[j]
		ldr r6, [r3]	// loads r6 with a[j] 
		add r3, r3, #4	// point to j + 1
		ldr r8, [r3]	// loads r8 with a[j + 1]
		cmp r1, r4		// j < array_size - 1 - i
		blt check_if
		add r0, r0, #1	// i++
		mov r1, #0		// j = 0
		b for_i
			
			check_if:
				cmp r6, r8				// a[j] > a[j + 1]
				bgt if_success
				add r1, r1, #1			// j++
				b for_j
					
					if_success:
						add r9, r8, #0	// temp = a[j + 1]
						str r6, [r3]	// a[j + 1] = a[j]
						sub r3, r3, #4	// points to a[j]
						str r9, [r3]	// a[j] = temp
						add r1, r1, #1	// j++
						b for_j
	
EXIT:
	pop {pc}
.data
	a:	.word	5,4,3,2,1,-1,0,50,40,30,8,-1