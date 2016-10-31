#int b;
#int c;
#int a[10];

#c = 5;
#b = c + 10; 
#a[8] = 8;
#a[4] = a[4] + 4;
#a[c] = a[8] + b + a[b & 0x7];


.pos 0x100
	
	# c = 5
	ld $c, r0 			# r0 = &c
	ld $5, r1			# r1 = 5
	st r1, 0(r0)		# r0 = 5

	# b = c + 10
	ld $b, r0			# r0 = address of b
	ld $c, r1			# r1 = address of c
	ld 0(r1), r1		# r1 = c
	ld $10, r2			# r2 = 10
	add r2, r1			# r1 = c + 10
	st r1, 0(r0)		# b = c + 10

	#a[8] = 8
	ld $8, r0 			# r0 = 8
	ld $a, r1			# r1 = &a
	st r0, (r1, r0, 4)	# a[8] = 8

	# a[4] = a[4] + 4
	ld $a, r0			# r0 = &a
	ld $4, r1			# r1 = 4
	ld (r0, r1, 4), r2	# r2 = a[4]
	add  r1, r2			# r2= a[4] + 4
	st r2, (r0, r1, 4)	# a[4] = a[4] + 4

	#a[c] = a[8] + b + a[b & 0x7];
	ld $a, r0			# r0 = &a
	ld $b, r1			# r1 = &b
	ld 0(r1), r1		# r1 = b
	mov r1, r3			# r3 = b
	ld $0x7, r2			# r2 = 0x7
	and r2, r3			# r3 = b & 0x7
	ld (r0, r3, 4), r3	# r3 = a[b & 0x7]
	add r3, r2			# r2 = b + a[b & 0x7]
	ld $8, r3			# r3 = 8
	ld (r0, r3, 4), r3	# r3 = a[8]
	add r2, r3			# r3 = a[8] + b + a[b & 0x7]
	ld $c, r2			# r2 = &c
	ld r2, 0(r2)		# r2 = c
	st r3, (r0, r2, 4)	# a[c] = a[8] + b + a[b & 0x7]

	
    # end
    halt

.pos 0x200
b: .long 0
c: .long 0
a: .long 0           # a[0]
   .long 0           # a[1]
   .long 0
   .long 0
   .long 0
   .long 0
   .long 0
   .long 0
   .long 0           # a[8]
   .long 0           # a[9]



