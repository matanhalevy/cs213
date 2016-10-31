.pos 0x100
    # c = 5
    ld $5, r0        # r0 = 5
    ld $c, r1        # r1 = &c
    st r0, 0(r1)     # c = 5

    # b = c + 10
    ld $c, r0        # r0 = &c
    ld 0(r0), r0     # r0 = c
    ld $10, r1       # r1 = 10
    add r1, r0       # r0 = c + 10
    ld $b, r1        # r1 = &b
    st r0, 0(r1)     # b = c + 10

    # a[8] = 8
    ld $8, r0        # r0 = 8
    ld $a, r1        # r1 = &a
    st r0, (r1,r0,4) # a[8] = 8

    # a[4] = a[4] + 4
    ld $4, r0        # r0 = 4
    ld $a, r1        # r1 = &a
    ld (r1,r0,4), r2 # r2 = a[4]
    add r0, r2       # r2 = a[4] + 4
    st r2, (r1,r0,4) # a[4] = a[4] + 4

    # a[c] = a[8] + b + a[b & 0x7]
    ld $a, r0        # r0 = &a
    ld $8, r1        # r1 = 8
    ld (r0,r1,4), r2 # r2 = a[8]
    ld $b, r3        # r3 = &b
    ld 0(r3), r3     # r3 = b
    add r3, r2       # r2 = a[8] + b
    ld $7, r1        # r1 = 0x7
    and r3, r1       # r1 = b & 0x7
    ld (r0,r1,4), r1 # r1 = a[b & 0x7]
    add r1, r2       # r2 = a[8] + b + a[b & 0x7]
    ld $c, r1        # r1 = &c
    ld 0(r1), r1     # r1 = c
    st r2, (r0,r1,4) # a[c] = a[8] + b + a[b & 0x7]

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
