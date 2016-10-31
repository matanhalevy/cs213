int a[8];
int b[8];
int c[8];
int i;
int *d = &c;

a[i] = a[i+1] + b[i+2];
d[i] = a[i] + b[i]
d[i] = a[b[i]] + b[a[i]];
d[b[i]] = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i];

.pos 0x100
	
	#a[i] = a[i+1] + b[i+2];
	ld $i, r0			# r0 = &i
	ld 0(r0), r0		# r0 = i
	ld $a, r1			# r1 = &a
	ld $b, r2			# r2 = &b
	mov r0, r3			# r3 = i
	inc r3				# r3 = i + 1
	ld (r1, r3, 4), r4 	# r4 = a[i+1]
	inc r3				# r3 = i + 2
	ld (r2, r3, 4), r2	# r2 = b[i+2]
	add r2, r4			# r4 = a[i+1] + b[i+2]
	st r4, (r1, r0, 4)	# a[i] = a[i+1] + b[i+2];

	#d[i] = a[i] + b[i]
	ld $i, r0			# r0 = &i
	ld 0(r0), r0		# r0 = i
	ld $a, r1			# r1 = &a
	ld $b, r2			# r2 = &b
	ld $d, r3			# r3 = &d
	ld (r1, r0, 4), r1	# r1 = a[i]
	ld (r2, r0, 4), r2	# r2 = b[i]
	add r2, r1			# r1 = a[i] + b[i]
	ld 0(r3), r3     	# r3 = d
	st r1, (r3, r0, 4)	# d[i] = a[i] + b[i]

	# d[i] = a[b[i]] + b[a[i]];
	ld $i, r0			# r0 = &i
	ld 0(r0), r0		# r0 = i
	ld $a, r1			# r1 = &a
	ld $b, r2			# r2 = &b
	ld $d, r3			# r3 = &d
	ld (r1, r0, 4), r4	# r4 = a[i]
	ld (r2, r0, 4), r5	# r5 = b[i]
	ld (r1, r5, 4), r1	# r1 = a[b[i]]
	ld (r2, r4, 4), r2	# r2 = b[a[i]]
	add r2, r1			# r1 = a[b[i]] + b[a[i]]
	ld 0(r3), r3     	# r3 = d
	st r1, (r3, r0, 4)	# d[i] = a[b[i]] + b[a[i]]

	#d[b[i]] = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i]
	ld $i, r0			# r0 = &i
	ld 0(r0), r0		# r0 = i
	ld $d, r1			# r1 = &d
	ld 0(r1), r1		# r1 = d
	ld (r1,r0,4),r2		# r2 = d[i]
	ld $3, r3			# r3 = 3
	mov r0, r4			# r4 = i
	and r3, r4			# r4 = i & 3
	ld $a, r5			# r5 = &a
	ld (r5,r4,4), r6	# r6 = a[i&3]
	and r3, r6			# r6 = a[i&3] & 3
	ld $b, r7			# r7 = &b
	ld  
