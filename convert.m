comment(`Andrew Wolstenholme cpsc 2310-003 Program 1 9/28/2018')
comment(`This program uses assembly language to convert a binary number')
comment(`to its decimal equivalent by using division and remainders')
comment(`Only the final decimal value is printed')

	word(N, 1101)
	word(remainder, 0)
	word(ten, 10)
	word(powOfTwo, 1)
	word(decimal, 0)
	word(two, 2)

label(start)

label(loop)

	load(N)
	div(ten)	
	store(remainder)	
	load(remainder)
	mul(ten)	comment(`remainder is N minus the LSB')
	store(remainder)
	load(N)
	sub(remainder)
	store(remainder)	comment(`difference of N and remainder, 0 or 1 ')

	load(N)
	div(ten)
	store(N)	comment(`update N by removing last bit')

	load(remainder)	comment(`add power of 2 times 1 or 0 then update powof2')
	mul(powOfTwo)	
	add(decimal)
	store(decimal)
	load(powOfTwo)
	mul(two)
	store(powOfTwo)
	
	
	load(N)
bgt0(loop)	comment(`Loop when N is 1 or more')
		


print(decimal)

halt
end(start)
