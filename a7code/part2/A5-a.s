.pos 0x0
                 ld   $sb, r5           # sp =  address of last of word of stack
                 inca r5                # sp = address of word after stack
                 gpc  $6, r6            # ra = pc + 6
                 j    0x300             # call to .pos 0x300
                 halt                     
.pos 0x100
                 .long 0x00001000         
.pos 0x200
                 ld   0x0(r5), r0       # r0 = arg0
                 ld   0x4(r5), r1       # r1 = arg1  
                 ld   $0x100, r2        # r2 = address 0x100   
                 ld   0x0(r2), r2       # r2 = 0x00001000  
                 ld   (r2, r1, 4), r3   # r3 = r2[arg1]  
                 add  r3, r0            # r0 = arg0 + r2[arg1] 
                 st   r0, (r2, r1, 4)   # r2[arg1] = arg0 + r2[arg1]  
                 j    0x0(r6)           # return  
.pos 0x300
                 ld   $0xfffffff4, r0   # r0 = -12 = -(size of caller part of main's frame) 
                 add  r0, r5            # allocate callee part of main's frame
                 st   r6, 0x8(r5)       # save the value of arg2 to stack  
                 ld   $0x1, r0          # r0 = 1, value of first arg  
                 st   r0, 0x0(r5)       # store value of arg0 to stack  
                 ld   $0x2, r0          # r0 = 2, value of second arg  
                 st   r0, 0x4(r5)       # store the value of arg1 to stack  
                 ld   $0xfffffff8, r0   # r0 = -8 = -(size of caller part of foo's frame)
                 add  r0, r5            # allocate callee part of part of foo's frame  
                 ld   $0x3, r0          # r0 = 3, value of third arg  
                 st   r0, 0x0(r5)       # store value of b0 to stack  
                 ld   $0x4, r0          # r0 = 4, value of forth arg  
                 st   r0, 0x4(r5)       # store value of b1 to stack  
                 gpc  $6, r6            # set return address      
                 j    0x200             # jump to .pos 0x200
                 ld   $0x8, r0          # r0 = 8, value of eighth argument  
                 add  r0, r5            # deallocate caller part of foo
                 ld   0x0(r5), r1       # r1 = c0  
                 ld   0x4(r5), r2       # r2 = c1  
                 ld   $0xfffffff8, r0   # r0 = -8 = -(size of caller part of foo's frame)  
                 add  r0, r5            # allocate caller part of foo
                 st   r1, 0x0(r5)       # store value of c0 to stack  
                 st   r2, 0x4(r5)       # store value of c1 to stack  
                 gpc  $6, r6            # set return address       
                 j    0x200             # call to .post 0x200, foo
                 ld   $0x8, r0          # r0 = 8, value of eighth argument  
                 add  r0, r5            # deallocate caller parts of foo's frame  
                 ld   0x8(r5), r6       # load return address from stack  
                 ld   $0xc, r0          # r0 = 12 = (size of caller part of main's frame)     
                 add  r0, r5            # deallocate callee part of mains frame  
                 j    0x0(r6)           # return  
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
