//Andrew Wolstenholme and Aaron Lattis 231 - 002
	.file "encode.s"
 	.global main
    	.global encode
 	.type encode, %function

/* function name:  encode
 
   description: takes 4 parameters and 
  
   input parameter(s):
	r0 - address of input string
	r1 - address of output string
	r2 - address of key string
	r3 - encode / decode switch
		0 == encode
		1 == decode
  
   return value (if any):
	none
     
   other output parameters:
	none
  
   effect/output
	r1 is the address of the output string
  
   method / effect:
	none
  
   typical calling sequence:
	
  
   local register usage:
	r4-r10
 */

encode:
	push {r4-r10, lr}
	cmp r3, #0
	beq to_encode

decode:
	mov r4, r0 //input addr copied to r4
	mov r5, r2 //key addr copied to r5	
	mov r7, r1 //output addr incremented each time
loop2:
	ldrb r8, [r4]	//input char in r8
	ldrb r10, [r5]	//key char in r10
	cmp r8, #32	//skip if space
	beq skip3
	cmp r10, #32	//skip if space
	beq skip3
	sub r8, r8, #96		//make in range 1-26
	sub r10, r10, #96	
	cmp r8, #-96		//if null char end
	beq end
	sub r8, r8, r10		//take difference of key and in
	cmp r8, #0		//if negative
	addlt r8, r8, #26	//condition add back into range
	add r8, r8, #96		//put in correct char range
skip3:	
	strb r8, [r7]	//put value of letter in current location of output string
	add r7, r7, #1	//output incremented
	add r4, r4, #1	//input incremented
	add r5, r5, #1 //key addr incremented
	
	ldrb r9, [r5]	//load char of key
	cmp r9, #0
	bne skip4
	mov r5, r2	//if key string is at the end, loop to front
skip4:
	b loop2		//always go back to loop


to_encode:

	mov r4, r0 //input addr copied to r4
	mov r5, r2 //key addr copied to r5	
	mov r7, r1 //output addr incremented each time
loop:
	ldrb r8, [r4]
	ldrb r10, [r5]
	cmp r8, #32	//skip if space
	beq skip
	cmp r10, #32	//skip of space
	beq skip
	sub r8, r8, #96		//make range 1-26
	sub r10, r10, #96	//make range 1-26
	cmp r8, #-96		//check if null char
	beq end			//end program
	add r8, r8, r10		//add key and input
	cmp r8, #26		//if more than 26
	subgt r8, r8, #26	//condition subtract back into range
	add r8, r8, #96		//put back into range
skip:	
	
	strb r8, [r7]	//put value of letter in current location of output str
	add r7, r7, #1	//output incremented
	add r4, r4, #1	//input incremented
	add r5, r5, #1 //key addr incremented
	
	ldrb r9, [r5]	//get key char
	cmp r9, #0	
	bne skip2
	mov r5, r2	//if key string is at the end, loop to front
skip2:
	b loop		//always go back to loop
end:	
	mov r8, #0
	strb r8, [r7]
	pop {r4-r10, pc}

