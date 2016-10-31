# struct S {
#   int       x[2];
#   int*      y;
#   struct S* z;
# };
#
# int      i;
# int      v;
# struct S s;

#void foo () {
# v = s.x[i];
# v = s.y[i];
# v = s.z->x[i];
#}

.pos 0x1000
code:
	#v = s.x[i];
	ld $i, r0		#r0 = &i
	ld 0(r0), r0	#r0 = i
	ld $s, r1		#r1 = &s
	ld (r1,r0,4),r2	#r2 = s.x[i]
	ld $v, r3		#r3 = &v
	st r2, (r3)		#v = s.x[i]

	#v = s.y[i];
	ld 8(r1), r4	#r4 = s.y
	ld (r4,r0,4),r4	#r4 = s.y[i]
	st r4,  (r3)	#v = s.y[i]

	# v = s.z->x [i];
	ld 12(r1), r4		#r4 = s.z
	ld (r4, r0, 4), r4  # r4 = s.z->x[i]
    st r4, (r3)         # v = s.z->x[i]
    halt                # question does not ask for return, so just stop

.pos 0x2000
static:
	i: 	.long 0
	v: 	.long 0
	s: 	.long 0         # x[0]
        .long 0         # x[1]
        .long heap0     # y
        .long heap1     # z

.pos 0x3000
heap0:  .long 0         # s.y[0]
        .long 0         # s.y[1]
heap1:  .long 0         # s.z->x[0]
        .long 0         # s.z->x[1]
        .long 0         # s.z->y
        .long 0         # s.z->z