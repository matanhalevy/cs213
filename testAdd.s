

loadindexed:

.pos 0x2000
a:               .long 0x00000140         # a[0]
                 .long 0x00300121         # a[1]
                 .long 0x00005123         # a[2]
                 .long 0xffffffff         # a[3]
                 .long 0xfff23464        # a[4]



ld $a, r0
ld $00 , r6
ld $02 , r5


st r0, (r6,r5,4)

ld(r6,r5,4), r3


halt
ld $0x00, r0
ld $0x00, r1
ld $0x00, r2
ld $0x00, r3
ld $0x00, r4
ld $0x00, r5
ld $0x00, r6
ld $0x00, r7
storebaseoffset:
ld $0x00, r1
ld $0x00, r0
ld $0x08, r7
st r7, 4(r0)
ld 4(r0), r1

halt
ld $0x00, r0
ld $0x00, r1
ld $0x00, r2
ld $0x00, r3
ld $0x00, r4
ld $0x00, r5
ld $0x00, r6
ld $0x00, r7
loadbaseoffset:
ld $0x04, r2  # load 4 to register 2
ld 4(r2), r0  # load the first offset of the mem address of r2 to r0



not:
ld $0x00, r0
ld $0x00, r1
ld $0x00, r2
ld $0x00, r3
ld $0x00, r4
ld $0x00, r5
ld $0x00, r6
ld $0x00, r7
ld $0x05, r2  # load 5 to register 2
not r2 # not r2

inc:
ld $0x00, r0
ld $0x00, r1
ld $0x00, r2
ld $0x00, r3
ld $0x00, r4
ld $0x00, r5
ld $0x00, r6
ld $0x00, r7
ld $0x05, r2  # load 5 to register 2
inc r2 # increase r2 by one

inca:
ld $0x00, r0
ld $0x00, r1
ld $0x00, r2
ld $0x00, r3
ld $0x00, r4
ld $0x00, r5
ld $0x00, r6
ld $0x00, r7
ld $0x05, r2  # load 5 to register 2
inca r2 # increase r2 by four

dec:
ld $0x00, r0
ld $0x00, r1
ld $0x00, r2
ld $0x00, r3
ld $0x00, r4
ld $0x00, r5
ld $0x00, r6
ld $0x00, r7
ld $0x05, r2  # load 5 to register 2
dec r2 #decrease r2 by 1

deca:
ld $0x00, r0
ld $0x00, r1
ld $0x00, r2
ld $0x00, r3
ld $0x00, r4
ld $0x00, r5
ld $0x00, r6
ld $0x00, r7
ld $0x05, r2  # load 5 to register 2
deca r2 # decrease r2 by four

move:
ld $0x00, r0
ld $0x00, r1
ld $0x00, r2
ld $0x00, r3
ld $0x00, r4
ld $0x00, r5
ld $0x00, r6
ld $0x00, r7
ld $0x05, r2  # load 5 to register 2
ld $0x07, r3  # load 7 to register 3
mov r2, r3   # load 7 to register 3

halt

add:
ld $0x00, r0
ld $0x00, r1
ld $0x00, r2
ld $0x00, r3
ld $0x00, r4
ld $0x00, r5
ld $0x00, r6
ld $0x00, r7
ld $0x05, r2  # load 5 to register 2
ld $0x07, r3  # load 7 to register 3
add r2, r3 # add r2 to r3 then save at r2
halt

and:
ld $0x00, r0
ld $0x00, r1
ld $0x00, r2
ld $0x00, r3
ld $0x00, r4
ld $0x00, r5
ld $0x00, r6
ld $0x00, r7
ld $0x05, r2  # load 5 to register 2
ld $0x07, r3  # load 7 to register 3
and r2, r3 # and them together

halt
shiftLeft:
ld $0x00, r0
ld $0x00, r1
ld $0x00, r2
ld $0x00, r3
ld $0x00, r4
ld $0x00, r5
ld $0x00, r6
ld $0x00, r7
ld $0x01, r0
shl $1, r0
shr $-1, r0
