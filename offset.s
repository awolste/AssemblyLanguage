//Andrew Wolstenholme 231 - 002
	.file "offset.s"
 	.global main
    	.global offset
 	.type offset, %function

/* function name:  offset
 
   description: takes 3 parameters and computes the amount of
		bits from the beginning of the array in the
		stack of the current index
  
   input parameter(s):
	r0 - row
	r1 - column
	r2 - number of columns per row
  
   return value (if any):
	r3: offset
     
   other output parameters:
	r3: offset
  
   effect/output
	r3 is set to the offset amount
	r8 = 4
  
   method / effect:
	none
  
   typical calling sequence:
	put row in r0
	put column in r1
	put number of columns in r2
  
   local register usage:
	r0 - row
	r1 - column
	r2 - number of columns
	r3: offset
	r8: 4
	r9: temporary usage
 */

offset:
        push  {lr}
	mov r3, #0
	mov r8, #4
        mul r3, r0, r2
	add r9, r3, r1
	mul r3, r9, r8
        pop   {pc}
