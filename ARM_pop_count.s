// Riley Taylor
// Dr. Jamieson
// 4/28/22
// Advanced Assembly pop count
// Using ARM generic

.global _start
_start:
	
	ldr r0, =input	// this will be the input value
	ldr r0, [r0]
	mov r1, #0		// sum
	mov r2, #0		// i = 0
	mov r4, #0
	
	b forLoop
	
forLoop:
	add r2, r2, #1	// i++
	and r3, r0, #1	// r3 = r0 and 1
	add r1, r1, r3	// sum += (input) & 1

	bl divide
	mov r0, r4
	mov r4, #0
	cmp r2, #32
	blt forLoop
	b EXIT
	
divide:
    cmp r0, #1
    ble return
	add r4, r4, #1
    sub r0, r0, #2
    b divide

return:
	bx lr
	
EXIT:
	pop {pc}
	
.data
	input:	.word	7501