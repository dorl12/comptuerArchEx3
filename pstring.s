# 313547085 Dor Levy
.section .rodata
print_invalid_input:				.string "invalid input!\n"

.text						# the beginning of the code

.global pstrlen				# defining the label “pstrlen”
.type pstrlen, @function			# defining “pstrlen” as function
pstrlen:					# the function gets a pointer to Pstring and returns the len of the string
    pushq   %rbp				# saving the old frame pointer
    movq    %rsp, %rbp          		# creating the new frame pointer
    xorq    %rax, %rax				# %rax = 0
    movb    (%rdi), %al			# set the len of the string to %rax
    movq    %rbp, %rsp				# restoring the old stack pointer
    pop     %rbp				# restoring the old frame pointer
    ret					# finish
 
.global replaceChar				# defining the label “replaceChar”
.type replaceChar, @function			# defining “replaceChar” as function
replaceChar:					# the function gets a pointer to Pstring, an old char and a new char and replaces the old char by the new char in the string
    pushq   %rbp				# saving the old frame pointer
    movq    %rsp, %rbp          		# creating the new frame pointer
    xorq    %r10, %r10				# %r10 = 0
    movb    (%rdi), %r10b       		# set the len of the string to %r10
    xorq    %r11, %r11          		# i = 0
    addq    $1, %rdi            		# adding 1 to the address of the Pstring in order to get the string
    .Loop_replaceChar:
    cmpb    (%rdi), %sil        		# compare Pstring[i] : oldChar
    je  .condition_replaceChar             	# if pstring[i] == oldChar goTo condition
    .body_replaceChar:
    incq    %rdi                		# Pstring++
    incl    %r11d               		# i++
    cmpl    %r10d, %r11d        		# comare i : len
    jl .Loop_replaceChar                    	# if <, goTo loop
    jmp .end_replaceChar                    	# goTo end of function
    .condition_replaceChar:
    movb    %dl, (%rdi)         		# replace Pstring[i] with new Char
    jmp .body_replaceChar			# goTo the body of the loop
    .end_replaceChar:
    movq    %rdi, %rax          		# set new Pstring as return value
    movq    %rbp, %rsp				# restoring the old stack pointer
    pop     %rbp				# restoring the old frame pointer
    ret					# finish
    
.global pstrijcpy				# defining the label “pstrijcpy”
.type pstrijcpy, @function			# defining “pstrijcpy” as function
pstrijcpy:					# the function gets two pointers to Pstring and two index and copies the subString(i,j)
						# of the second Pstring to the first Pstring and returns a pointer to the first Pstring
    pushq   %rbp				# saving the old frame pointer
    movq    %rsp, %rbp          		# creating the new frame pointer
    
    movq    %rcx, %r10				# set j to %r10
    addq    $1,%r10				# adding 1 to j
    
    xorq    %r11,%r11				# %r11 = 0
    movb    (%rsi),%r11b			# set the len of the second string to %r11
    cmpq    %r10, %r11				# compare len : j 
    jl  .invalid_input_cpy			# if <, goTo invalid input
    
    xorq    %r11,%r11				# %r11 = 0
    movb    (%rdi),%r11b			# set the len of the first string to %r11
    cmpq    %r10, %r11				# compare len : j 
    jl  .invalid_input_cpy			# if <, goTo invalid input
    
    xorq    %r10, %r10          		# %r10 = 0
    xorq    %r11, %r11          		# %r11 = 0
    leaq    (%rsi,%rdx,1), %r10 		# set the address of src[i] into %r10
    leaq    (%rdi,%rdx,1), %r11 		# set the address of dst[i] into %r11
    
    addq    $1, %r10            		# adding 1 to the address of src in order to get the string
    addq    $1, %r11            		# adding 1 to the address of dst in order to get the string
    .Loop_cpy:
    xorq    %rax, %rax          		# %rax = 0
    movb   (%r10),%al           		# set src[i] into %rax
    movb    %al, (%r11)         		# set %rax into dst[i]
    incq    %r10                		# src++
    incq    %r11                		# dst++
    incb    %dl                 		# i++       
    cmp     %cl, %dl            		# compare i : j
    jle .Loop_cpy                  		# if <=, goTo loop
    jmp .finish_cpy				# else, go to the end of the function
    
    .invalid_input_cpy:
    movq    $print_invalid_input, %rdi	# set the print format as the first parameter of printf
    xorq    %rax, %rax				# %rax = 0
    call    printf				# call the function printf
    xorq    %rax,%rax				# %rax = 0
    
    .finish_cpy:
    movq    %rdx, %rax          		# set the address of dst as return value
    movq    %rbp, %rsp				# restoring the old stack pointer
    pop     %rbp				# restoring the old frame pointer
    ret					# finish

.global swapCase				# defining the label “swapCase”
.type swapCase, @function			# defining “swapCase” as function
swapCase:					# the function gets a pointer to Pstring and replaces every capital letter to lower case letter and
						# every lower case letter to capital letter
    pushq   %rbp				# saving the old frame pointer
    movq    %rsp, %rbp          		# creating the new frame pointer
    
    movq    %rdi,%r10           		# set the address of the Pstring to %r10
    xorq    %r11,%r11				# %r11 = 0
    movb    (%r10),%r11b        		# set the len of the string to %r11
    addq    $1,%r10             		# adding 1 to the address of Pstring in order to get the string
    xorq    %r12,%r12           		# i = 0
    .Loop_swap:
    cmp     %r12b,%r11b         		# compare len : i
    ja  .check_char				# if >, goTo loop
    jmp .finish_swap				# else, go to the end of the function
    
    .check_char:
    xorq    %rax,%rax				# %rax = 0
    movb    (%r10),%al				# set Pstring[i] to %rax
    cmp     $122,%rax				# compare Pstring[i] : 122
    ja .inc_i					# if >, goTo inc_i 
    cmp     $65,%rax				# compare Pstring[i] : 65
    jl .inc_i					# if <, goTo inc_i 
    
    .big_letter:
    cmp     $90,%rax				# compare Pstring[i] : 90
    jg  .small_letter				# if >, goTo the case of lower case letter according to ASCII table
    addq    $32,%rax				# add 32 to %rax in order to replace capital letter by lower case letter according to ASCII table
    movb    %al,(%r10)				# set %rax as Pstring[i]
    jmp .inc_i					# goTo inc_i
    
    .small_letter:
    cmp     $97,%rax				# compare Pstring[i] : 97
    jl  .inc_i					# if <, goTo inc_i because it's not a letter according to ASCII table
    subq    $32,%rax				# sub %rax by 32 in order to replace lower case letter by capital letter according to ASCII table
    movb    %al,(%r10)				# set %rax as Pstring[i]
    
    .inc_i:
    incq    %r10				# Pstring++
    incb    %r12b				# i++
    jmp .Loop_swap				# goTo loop
    
    .finish_swap:
    movq    %r10, %rax				# set new Pstring as return value
    movq    %rbp, %rsp				# restoring the old stack pointer
    pop     %rbp				# restoring the old frame pointer
    ret					# finish
    
.global pstrijcmp				# defining the label “pstrijcmp”
.type pstrijcmp, @function			# defining “pstrijcmp” as function
pstrijcmp:					# the function gets two pointers to Pstring and two index and compares the subString(i,j)
						# of the first Pstring to the subString(i,j) of the second Pstring
    pushq   %rbp				# saving the old frame pointer
    movq    %rsp, %rbp				# creating the new frame pointer
    
    movq    %rcx, %r10				# set j to %r10
    addq    $1,%r10				# adding 1 to j
    
    xorq    %r11,%r11				# %r11 = 0
    movb    (%rsi),%r11b			# set the len of the first string to %r11
    cmpq    %r10, %r11				# compare len : j 
    jl  .invalid_input_cmp			# if <, goTo invalid input
    
    xorq    %r11,%r11				# %r11 = 0
    movb    (%rdi),%r11b			# set the len of the second string to %r11
    cmpq    %r10, %r11				# compare len : j 
    jl  .invalid_input_cmp			# if <, goTo invalid input
    
    xorq    %r10, %r10          		# %r10 = 0
    xorq    %r11, %r11          		# %r11 = 0
    leaq    (%rdi,%rdx,1), %r10 		# set the address of pstr1[i] into %r10
    leaq    (%rsi,%rdx,1), %r11 		# set the address of pstr2[i] into %r11
    
    addq    $1, %r10            		# adding 1 to the address of pstr1 in order to get the string
    addq    $1, %r11            		# adding 1 to the address of pstr2 in order to get the string
    
    .Loop_cmp:
    xorq    %r12,%r12				# %r12 = 0
    xorq    %r13,%r13				# %r13 = 0
    movb    (%r10),%r12b			# set pstr1[i] in %r12
    movb    (%r11),%r13b			# set pstr2[i] in %r13
    cmp     %r12b,%r13b			# compare pstr2[i] : pstr1[i]
    jl  .pstr1_bigger				# if <, goTo pstr1_bigger
    jg  .pstr2_bigger				# if >, goTo pstr2_bigger
    je  .continue				# if =, goTo continue
    
    .continue:
    incq    %r10                		# pstr1++
    incq    %r11                		# pstr2++
    incb    %dl                 		# i++
    jmp .check_index				# goTo check_index
    
    .check_index:
    cmp     %cl, %dl            		# compare i : j
    jle .Loop_cmp                  		# if <=, goTo loop
    movq    $0,%rax				# %rax = 0
    jmp .finish_cmp				# goTo finish_cmp
    
    .pstr1_bigger:
    movq    $1,%rax				# %rax = 1
    jmp .finish_cmp				# goTo finish_cmp
    
    .pstr2_bigger:
    movq    $-1,%rax				# %rax = -1
    jmp .finish_cmp				# goTo finish_cmp
    
    .invalid_input_cmp:
    movq    $print_invalid_input, %rdi	# set the print format as the first parameter of printf
    xorq    %rax, %rax				# %rax = 0
    call    printf				# call the function printf
    movq    $-2,%rax				# %rax = -2
    
    .finish_cmp:
    movq    %rbp, %rsp				# restoring the old stack pointer
    pop     %rbp				# restoring the old frame pointer
    ret					# finish
