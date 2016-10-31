.pos 0x1000
add:
	irmovq $1, %rbx #rbx = 1
	irmovq $1, %rbp #rbp = 1
	addq %rbp, %rbx #rbx = 2
	iaddq $1, %rbx  #add 1 to rbx = 3
	isubq $1, %rbx  #substract 1 from rbx = 2
	imulq $20, %rbx #multiply 2*20 = 40
	idivq $5, %rbx	# divide 40/5 = 8
	imodq $3, %rbx	# mod 8 by 3 = 2
	iandq $2, %rbx 	# %rbx should still = 2
	iandq $5, %rbx	# %rbx = 0
	imulq $5, %rbx 	# %rbx = 0 --> multiply by 0 should still be 0
	#ixorq $0, %rbx	# %rbx = 1
	iaddq $10, %rbx	#%rbx = 11
	ixorq $5, %rbx	#%rbx = 11
	
	halt
