# 313547085 Dor Levy
.section .rodata
format_scan_d:    .string "%d"
format_scan_s:    .string "%s"
.text					# the beginning of the code
.global run_main			# defining the label “run_main”
.type run_main, @function		# defining “run_main” as function
run_main:				# the function gets from the user the info of two Pstrings and an option number and calls the function run_func
    pushq   %rbp			# saving the old frame pointer
    movq    %rsp, %rbp			# creating the new frame pointer
    
    sub     $528, %rsp			# allocating bytes for two Pstrings and an option number(8 byets more because of alignment)
    
    movq    $format_scan_d, %rdi	# set the first parameter of scanf to %rdi
    leaq    -518(%rbp), %rsi		# set the second parameter of scanf to %rsi
    xorq    %rax, %rax			# %rax = 0
    call    scanf			# getting the len of the first string
    
    movq    $format_scan_s, %rdi	# set the first parameter of scanf to %rdi
    leaq    -517(%rbp), %rsi		# set the second parameter of scanf to %rsi
    xorq    %rax, %rax			# %rax = 0
    call    scanf			# getting the first string
    
    movq    $format_scan_d, %rdi	# set the first parameter of scanf to %rdi
    leaq    -261(%rbp), %rsi		# set the second parameter of scanf to %rsi
    xorq    %rax, %rax			# %rax = 0
    call    scanf			# getting the len of the second string
    
    movq    $format_scan_s, %rdi	# set the first parameter of scanf to %rdi
    leaq    -260(%rbp), %rsi		# set the second parameter of scanf to %rsi
    xorq    %rax, %rax			# %rax = 0
    call    scanf			# getting the second string
    
    movq    $format_scan_d, %rdi	# set the first parameter of scanf to %rdi
    leaq    -4(%rbp), %rsi		# set the second parameter of scanf to %rsi
    xorq    %rax, %rax			# %rax = 0
    call    scanf			# getting the option number
    
    leaq    -4(%rbp), %r10		# set the address of the option number to %r10
    movl    (%r10), %edi		# set option number to %rdi
    leaq    -518(%rbp), %rsi		# set the address of the first Pstring to %rsi
    leaq    -261(%rbp), %rdx		# set the address of the second Pstring to %rdx
    call    run_func			# call the function run_func
    
    add     $528, %rsp			# releasing the allocated memory from the stack
    movq    %rbp, %rsp			# restoring the old stack pointer.
    popq    %rbp			# restoring the old frame pointer.
    xorq    %rax, %rax			# %rax = 0
    ret			                # finish
    
    

    
