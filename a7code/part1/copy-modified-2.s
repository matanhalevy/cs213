#intializing the code






.pos 0x100
  start:          ld   $stackBtm, r5       # [01] sp = address of last word of stack
                  inca r5                  # [02] sp = address of word after stack
                  gpc  $0x6, r6            # [03] r6 = pc + 6
                  j    main                # [04] call main


.pos 0x200
  main:           deca r5

				  gpc $6, r6               # r6 = pc + 6
				  st r6, (r5)              # saving ra onto the stack
				  j copy                   # call copy

				  ld   (r5), r6            #  load ra from stack
          inca r5                  #  remove callee part of stack frame

         halt



.pos 0x300
copy:            ld $0xfffffff4, r0        # load -12 to r0
                 add r0, r5                # moving the stack pointer up

                 ld $0, r0                 # r[0] will now be my i
                 ld $src, r1               # r[1] will be the address of src
                 ld 0(r1), r2              # make r2 src[i]


loop:            beq r2 , endloop          # r1 will be src[i] , if that is = 0 endloop

                 ld (r1, r0, 4), r2        # r2 = src[i] will have the index and offset of i
                 st r2,( r5 ,r0, 4)        # dec[i] = src[i]
                 inc r0                    # increment i
                 j loop


endloop:         ld $0 , r4                # r4 = 0
                 st r4, (r5, r0, 4)        # dec[i] = 0

                 ld $0x0c , r0             # r0 = 12
                 add r0, r5

                 ld 0(r5) , r6
                 j (r6)                    # jump back to main


.pos 0x1000
stackTop:        .long 0x0
                 .long 0x0
                 .long 0x0
                 .long 0x0
                 .long 0x0
                 .long 0x0
                 .long 0x0
                 .long 0x0
                 .long 0x0
stackBtm:        .long 0x0




.pos 0x500
src: .long 0x510
     .long 0x510
     .long 0x510
     .long 0x510
    .long 0xff00ff00 #nop slide
    .long 0xff00ff00
   .long 0x0000ffff  #setting registers to zero.
	 .long 0xffff0100
	 .long 0xffffffff
	 .long 0x0200ffff
	 .long 0xffff0300
	 .long 0xffffffff
	 .long 0x0400ffff
   .long 0xffff0500
	.long 0xffffffff
   .long 0x0600ffff
		 .long 0xffff0700
		 .long 0xffffffff

.long 0xf000ffff # halt
