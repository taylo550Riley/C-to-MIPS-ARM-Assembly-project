// Riley Taylor
// Dr. Jamieson
// 4/28/22
// Advanced Assembly GCD
// Recursive GCD, slowly works toward the GCD by the use of subtraction
// works with 0 inputs as well
// Using ARMv7 generic

.global _start
_start:
	
	mov r0, #13
	mov r1, #52
	mov r2, #0
	
	b GCD

GCD:
	cmp r0, #0
	beq resultR1
	cmp r1, #0
	beq resultR0
	cmp r0, r1
	beq EXIT
	cmp r0, r1
	bge subtract
	sub r1, r1, r0
	b GCD

resultR0:
	add r2, r0, #0
	b EXIT
	
resultR1:
	add r2, r1, #0
	b EXIT
	
subtract:
	sub r0, r0, r1
	b GCD
	
EXIT:
	add r2, r0, #0
	pop {pc}