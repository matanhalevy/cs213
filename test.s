.pos 0x100
        
ld $a, r1                # r1 = &a;
ld 0(r1),r1              # r1 = a;
ld $b, r2                # r2 = &b;
ld 0(r2), r2             # r2 = b;
br if                    # goto +1
ld $5, r0                # r0 = 5;

if:
beq r2, then             # if(b=0) goto +1

else:
ld $6, r3                # r3 = 6;

then:
beq r1, if2              # if(a=0) goto +3
ld $7, r4                # r4 = 7;
br if2                   # goto +1
ld $8, r5                # r5 = 8;

if2: 
bgt r2, then2            # if(b>0) goto +1

else2:
bgt r1, foo              # if(a>0) goto +1

then2:
ld $9, r6                # r6 = 9;

foo: 
gpc  $0, r7              # r7 = pc
j ping                   # goto ping
halt                     # halt
ld $5, r0                # r0 = 5;


.pos 0x500
ping:            
j    8(r7)                # return


.pos 0x1000
a:               .long 0x00000001         # a
.pos 0x2000
b:               .long 0x00000000         # b
