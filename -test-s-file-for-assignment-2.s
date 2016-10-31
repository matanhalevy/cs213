# test s file for assignment 2 
# CPSC 313 
# Wesley Hong 


#DATA
.pos 0x100
.align 8
.quad 0 
arr1:  .quad 0x1 
       .quad 0x2 
       .quad 0x3 
       .quad 0x4 
       .quad 0x5 
       .quad 0x6 
       .quad 0x0  
       .quad 0x0 
       .quad 0x0  
       .quad 0x0 
       .quad 0x0  
       .quad 0x0 
       .quad 0x0  
       .quad 0x0

arr2:
       .quad 0x8888
       


.pos 0x1000
# TESTING THE I_IOPQ 

#iraddq 
irmovq $5, %rcx       #rcx = 5 
iaddq $5, %rcx        #rcx = 10
iaddq $-10, %rcx      #rcx = 0
iaddq $0, %rcx        #rcx = 0
iaddq $-1, %rcx       #rcx = -1
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #overflow
iaddq $999999999999999999, %rcx #becomes negative, overflow works

xorq %rcx, %rcx       #rcx = 0 

#isubq

isubq $0, %rcx        #rcx = 0
isubq $1, %rcx        #rcx = -1
isubq $-1, %rcx        #rcx = 0
isubq $999999999999999999, %rcx   #overflow
isubq $999999999999999999, %rcx   #overflow
isubq $999999999999999999, %rcx   #overflow
isubq $999999999999999999, %rcx   #overflow
isubq $999999999999999999, %rcx   #overflow
isubq $999999999999999999, %rcx   #overflow
isubq $999999999999999999, %rcx   #overflow
isubq $999999999999999999, %rcx   #overflow
isubq $999999999999999999, %rcx   #overflow
isubq $999999999999999999, %rcx   #overflow
isubq $999999999999999999, %rcx   #overflow
isubq $999999999999999999, %rcx   #becomes positive, overflow works

xorq %rcx, %rcx       #rcx = 0 

#imulq

imulq $0, %rcx        #rcx = 0
imulq $1, %rcx        #rcx = 0
iaddq $1, %rcx         #rcx = 1
imulq $50, %rcx       #rcx = 50
imulq $-1, %rcx       #rcx = -50
imulq $-999999999999999999, %rcx       #overfow, becomes negative, overflow works
imulq $0, %rcx        #rcx = 0

#idivq

idivq $1, %rcx        #rcx = 0
irmovq $1, %rcx       #rcx = 1
idivq $1, %rcx        #rcx = 1
idivq $2, %rcx        #rcx = 0
irmovq $2, %rcx       #rcx = 2
idivq $1, %rcx        #rcx = 2
idivq $-1, %rcx       #rcx = -2

#iandq

xorq %rcx, %rcx       #rcx = 0 
iandq $0, %rcx        #rcx = 0
iandq $123123, %rcx   #rcx = 0
irmovq $123, %rcx     #rcx = 123
iandq $123, %rcx      #rcx = 123

#imodq

imodq $123, %rcx      #rcx = 0
irmovq $17, %rcx      #rcx = 17
imodq $123, %rcx      #rcx = 17
imodq $-1, %rcx       #rcx = 0


irmovq $-5, %rcx      #rcx = -5
iaddq  $10, %rcx      #rcx=  5  

xorq %rcx, %rcx       #rcx = 0 

#isubq

irmovq $5, %rax       #rax = 5 
isubq  $1, %rax       #rax = 4  
subq   %rcx, %rax     #rax = 6-10 = -4 

xorq %rax, %rax       #rax = 0

#ixorq 

irmovq $15, %rax    #rax = 15 
ixorq  $1, %rax     #rax = 14
ixorq $-1, %rax     #rax = -15
ixorq $0, %rax      #rax = -15


xorq %rax, %rax     #rax = 0 

#iandq 
irmovq $31, %rax   #rax = 0x31 
iandq $15, %rax    #rax = 0x15 
iandq $0 , %rax    #rax = 0 

#---------------rmmovq---------------

#rmmovq (normal)

irmovq arr1, %rbx    # rbx is arr1 
irmovq $0xADEAFBEE, %rcx # rcx= adeafbee
rmmovq %rcx, 0x38(%rbx)  # arr1[8] = adeafbee


#rmmovq 
irmovq $7, %rax  #rax=0x7
irmovq $6, %rbx  #rbx= arrq
rmmovq %rax, arr1(%rbx,8)  # arr1[7] = 7 



#---------------mrmovq------------------

#mrmovq(normal)
xorq %rax, %rax
xorq %rbx, %rbx 
xorq %rcx, %rcx
irmovq arr1, %rbx    # rbx is arr1 
mrmovq 0x38(%rbx), %rcx  #rcx = adeafbee


xorq %rax, %rax
xorq %rbx, %rbx 
xorq %rcx, %rcx
#mrmovq 
irmovq $7, %rax  #rax=0x7
irmovq $6, %rbx  #rbx= arrq
mrmovq arr1(%rbx,8),%rcx 
mrmovq arr1(%rax,8),%rsi

#------------------------------------------

#rmmovq 
#tests that should fail but doesn't (array out of bounds)
xorq %rax, %rax
xorq %rbx, %rbx 
xorq %rcx, %rcx

irmovq $0xDEAD, %rax  #rax= DEAD
irmovq $-1, %rbx  #rbx= -1
rmmovq %rax, arr1(%rbx,8)  # arr1[-1] = DEAD (array out of bounds)

#irmovq
xorq %rax, %rax
xorq %rbx, %rbx 
xorq %rcx, %rcx

irmovq $-1, %rbx  #rbx= -1 
mrmovq arr1(%rbx,8), %rax    # rax = arr1[-1]??

#---------------------------------------------------
# other implementations 
irmovq $0x0a, %rbx  #rbx= 10
rmmovq %rax, 0x100(%rbx,8)  # can it read directly through memory ? 

irmovq $0x5 , %rcx    # rcx = 5 
mrmovq 0x100(%rcx,8) , %rax  #arr1[8] = %rax
#-----------------------------------------

#call (ra) 
irmovq $0x5555 , %rax
call (%rax)

.pos 0x5555
irmovq $0, %rbx              #rbx = 0
mrmovq arr2(%rbx, 8), %rcx    #rcx = arr2[0]
call (%rcx)

.pos 0x8888
irmovq $0, %rcx
halt
