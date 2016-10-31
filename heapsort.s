	.file	"heapsort.c"
	.text
	.p2align 4,,15
	.globl	heapsort
	.type	heapsort, @function
heapsort:
.LFB11:
	.cfi_startproc
	pushq	%rbx					 # save last onto the stack
	.cfi_def_cfa_offset 16           #
	.cfi_offset 3, -16               #
	movl	%edi, %ebx               # move current argument (last) into rbx
	call	heapify_array            # call heapify_array
	testl	%ebx, %ebx               # check to see if i >= 0
	js	.L1                          # jump to L1 (exit loop)
	.p2align 4,,10
	.p2align 3
.L7:
	movl	%ebx, %edi             # move %ebi (i) into argument register for use in extract_max
	call	extract_max            # calls extract_max function
	movslq	%ebx, %rdx             # move result of extract_max into rdx, with sign extension
	subl	$1, %ebx               # i--
	cmpl	$-1, %ebx              # i == -1 ?
	movl	%eax, heap(,%rdx,4)    # heap[i] = result form extract_max
	jne	.L7                        # loop
.L1:
	popq	%rbx                    # pop the argument off the stack
	.cfi_def_cfa_offset 8           # offset : debugging purposes
	ret                             # return the value
	.cfi_endproc                    # end the program
.LFE11:
	.size	heapsort, .-heapsort
	.ident	"GCC: (SUSE Linux) 4.8.1 20130909 [gcc-4_8-branch revision 202388]"
	.section	.note.GNU-stack,"",@progbits