#int src[2] = {1,0};

#void copy() {
#  int dst[2];
#  int i = 0;
#  while (src[i] != 0) {
#    dst[i] = src[i];
#    i++;
#  }
#  dst[i]=0;
#}

#int main () {
#  copy ();
#}

.pos 0x100
start:
	ld $0x8000, r5		#init stack pointer
	gpc $6, r6
	j main				# call main()
	halt				#end

main:
	deca r5
	st r6, (r5)			# save RA
	gpc $6, r6			
	j copy				# call copy
	ld (r5), r6			
	inca r5				# pop RA
	j (r6)				# return

copy:
	deca r5
	st r6, (r5)			#save RA
	deca r5
	deca r5				# allocate dst[2]
	ld $0, r0			# r0(i) = 0
	ld $src,r1			# r1 = &src
	

