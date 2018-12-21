/*
	Andrew Wolstenholme (awolste) 
	2310 - 002 
	prog3
	Nov 9, 2018

	Description: this program takes an index in a 2d array
	and the number of columns in a row and computes the offset
	value using a subroutine found in offset.s. The offset is
	the amount of bits from the beginning of the array in the
	stack of the current index.
*/
	.file "main.s"
 	.global main
 	.type main, %function
/*
	r0: row
	r1: column
	r2: number of columns
	r3: offset
*/
main:
	push {r4, lr}
	
	mov r4, r1	//string of command line args

 	ldr r0, [r4, #4]	//argv [1]
	bl atoi
	mov r5, r0

	ldr r0, [r4, #8]	//argv [2]
	bl atoi
	mov r6, r0

	ldr r0, [r4, #12]	//argv [3]
	bl atoi
	mov r7, r0

	mov r0, r5		//put params in 0, 1, 2 for offset
	mov r1, r6
	mov r2, r7

	bl offset

	mov r1, r5		//put correct vals in 0, 1, 2 for print
	mov r2, r6
        ldr r0, =fmt1            
	
        bl printf

done:
        mov  r0, #0
        pop {r4, pc}

        .section ".rodata"
fmt1:
        .asciz "the offset for a[%d][%d] is %d\n"
