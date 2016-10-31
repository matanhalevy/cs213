.pos 0x0
                 ld   $sb, r5                   # sp = address of last word of stack
                 inca r5                        # sp = address of word after stack
                 gpc  $6, r6                    # r6 = pc + 6
                 j    0x300                     # jump to .pos 0x300
                 halt                     
.pos 0x100
                 .long 0x00001000
.pos 0x200
foo:             ld   0x0(r5), r0               # r0 = a0
                 ld   0x4(r5), r1               # r1 = a1
                 ld   $0x100, r2                # r2 = address 0x100
                 ld   0x0(r2), r2               # r2 = 0x00001000
                 ld   (r2, r1, 4), r3           # r3 = r2[a1]
                 add  r3, r0                    # r0 = a0 + r2[a1]
                 st   r0, (r2, r1, 4)           # r2[a1] = a0 + r2[a1]
                 j    0x0(r6)                   # return
.pos 0x300
                 ld   $0xfffffff4, r0           # r0 = -12 = -(size of caller part of main's frame)
                 add  r0, r5                    # allocate callee part of main's frame
                 st   r6, 0x8(r5)               # save the value of a2 to stack
                 ld   $0x1, r0                  # r0 = 1
                 st   r0, 0x0(r5)               # store value of a0 to stack
                 ld   $0x2, r0                  # r0 = 2
                 st   r0, 0x4(r5)               # store the value of a1 to stack

                 ld   $0xfffffff8, r0           # r0 = -8 = -(size of caller part of 0x200's (foo) frame)
                 add  r0, r5                    # allocate caller part of foo's frame
                 ld   $0x3, r0                  # r0 = 3
                 st   r0, 0x0(r5)               # store value of b0 to stack
                 ld   $0x4, r0                  # r0 = 4
                 st   r0, 0x4(r5)               # store value of b1 to stack
                 gpc  $6, r6                    # set return address
                 j    0x200                     # jump to .pos 0x200

                 ld   $0x8, r0                  # r0 = 8
                 add  r0, r5                    # deallocate caller part of foo's frame
                 ld   0x0(r5), r1               # r1 = c0
                 ld   0x4(r5), r2               # r2 = c1

                 ld   $0xfffffff8, r0           # r0 = -8 = -(size of caller part of foo's frame)
                 add  r0, r5                    # allocate caller part of foo's
                 st   r1, 0x0(r5)               # store value of c0 to stack
                 st   r2, 0x4(r5)               # store value of c1 to stack
                 gpc  $6, r6                    # set return address
                 j    0x200                     # jump to .pos 0x200 (foo)

                 ld   $0x8, r0                  # r0 = 8
                 add  r0, r5                    # deallocate caller parts of foo's frame
                 ld   0x8(r5), r6               # load return address from stack

                 ld   $0xc, r0                  # r0 = 12 = size of callee part of main's frame
                 add  r0, r5                    # deallocate callee parts of main's frame
                 j    0x0(r6)                   # return
.pos 0x1000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
