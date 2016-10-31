.pos 0x100
start:
    ld $sb, r5                  # sp = address of last word of stack
    inca    r5                  # sp = address of word after stack
    gpc $6, r6                  # r6 = pc + 6
    j main                      # call main()
    halt

f:
    deca r5                     # allocate callee part of f's frame
    ld $0, r0                   # r0 = a = 0;
    ld 4(r5), r1                # r1 = b = r6
    ld $0x80000000, r2          # r2 = c = 0x80000000
f_loop:
    beq r1, f_end               # if b == 0 branch to f_end
    mov r1, r3                  # r3 = b
    and r2, r3                  # r3 = c & b
    beq r3, f_if1               # if r3 == 0, branch to f_if1
    inc r0                      # a++
f_if1:
    shl $1, r1                  # b << 1
    br f_loop                   # branch to f_loop
f_end:
    inca r5                     # deallocate callee part of f's frame
    j(r6)                       # return

main:
    deca r5                     # allocate callee part of main's frame
    deca r5                     # ""
    st r6, 4(r5)                # store return address in stack
    ld $8, r4                   # r4 = i = 8
main_loop:
    beq r4, main_end            # if i == 0, branch to main_end
    dec r4                      # i--
    ld $x, r0                   # r0 = x
    ld (r0,r4,4), r0            # r0 = x[i]
    deca r5                     # allocate callee part of main's fram
    st r0, (r5)                 # store x[i] in r5
    gpc $6, r6                  # r6 = pc + 6
    j f                         # jump to f()
    inca r5                     # deallocate callee part of main's fram
    ld $y, r1                   # r1 = y
    st r0, (r1,r4,4)            # y[i] = x[i]
    br main_loop                # branch to main_loop
main_end:
    ld 4(r5), r6                # load return address from stack
    inca r5                     # deallocate callee part of main's frame
    inca r5                     # ""
    j (r6)                      # return

.pos 0x2000
x:
    .long 1
    .long 2
    .long 3
    .long 0xffffffff
    .long 0xfffffffe
    .long 0
    .long 184
    .long 340057058

y:
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0

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

