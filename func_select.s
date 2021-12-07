# 313547085 Dor Levy
.section .rodata
scan_c:    					.string " %c"
scan_d:    					.string "%d"
scan_s:    					.string "%s"
print_c:   					.string "%c\n"
print_d:   					.string "%d\n"
print_s:   					.string "%s\n"
print_case_5060:  				.string "first pstring length: %d, second pstring length: %d\n"
print_case_52:  				.string "old char: %c, new char: %c, first string: %s, second string: %s\n" 
print_case_53:  				.string "length: %d, string: %s\n"
print_case_54:  				.string "length: %d, string: %s\n" 
print_case_55:  				.string "compare result: %d\n"
invalid_option:				.string "invalid option!\n"

.align 8        				# Align address to multiple of 8

.jumpTable:
    .quad .case_5060   			# Case 50: loc_A
    .quad .case_invalid_input   		# Case 51: loc_def
    .quad .case_52   				# Case 52: loc_B
    .quad .case_53   				# Case 53: loc_C
    .quad .case_54 				# Case 54: loc_D
    .quad .case_55  				# Case 55: loc_E
    .quad .case_invalid_input  		# Case 56: loc_def
    .quad .case_invalid_input			# Case 57: loc_def
    .quad .case_invalid_input   		# Case 58: loc_def
    .quad .case_invalid_input   		# Case 59: loc_def
    .quad .case_5060   			# Case 60: loc_A

.text						# the beginning of the code
.global run_func				# defining the label “run_func”
.type run_func, @function			# defining “run_func” as function
run_func:					# the function runs a switch case program according to the option number entered by the user
    pushq   %rbp				# saving the old frame pointer
    movq    %rsp, %rbp          		# creating the new frame pointer
    sub     $16, %rsp           		# getting place for 16 bytes in the stack
    leaq    -50(%rdi), %r10     		# Compute xi = x-50
    cmpq    $10, %r10           		# Compare xi:10
    ja .case_invalid_input  			# if >, goto default-case
    jmp     *.jumpTable(,%r10,8)		# Goto jumpTable[xi]
    .case_5060:
            movq    %rsi, %r14		# set the address of the first Pstring to %r14	
            movq    %rdx, %r15		# set the address of the second Pstring to %r15
            
            movq    %r14, %rdi		# set the address of the first Pstring to %rdi
            xorq    %rax,%rax			# %rax = 0
            call    pstrlen			# call the function pstrlen
            movq    %rax,%r10			# set the return value to %r10
            
            movq    %r15, %rdi		# set the address of the second Pstring to %r15
            xorq    %rax,%rax			# %rax = 0
            call    pstrlen			# call the function pstrlen
            movq    %rax,%r11			# set the return value to %r11
            
            movq    %r10,%rsi			# set the len of the first string as the second parameter of printf
            movq    %r11,%rdx			# set the len of the second string as the third parameter of printf
            movq    $print_case_5060, %rdi	# set the print format as the first parameter of printf
            xorq    %rax, %rax		# %rax = 0
            call    printf			# call the function printf
            jmp .end_of_run_func		# Goto the end of run_func
    .case_52:
            movq    %rsi, %r14		# set the address of the first Pstring to %r14
            movq    %rdx, %r15 		# set the address of the second Pstring to %r15
            
            movq    $scan_c, %rdi		# set the first parameter of scanf to %rdi
            leaq    -16(%rbp), %rsi		# set the second parameter of scanf to %rsi
            xorq    %rax, %rax		# %rax = 0
            call    scanf			# getting the old char from the user
            
            xorq    %r12, %r12		# %r12 = 0
            movb    -16(%rbp), %r12b		# set the old char to %r12
            
            movq    $scan_c, %rdi		# set the first parameter of scanf to %rdi
            leaq    -15(%rbp), %rsi		# set the second parameter of scanf to %rsi
            xorq    %rax, %rax		# %rax = 0
            call    scanf			# getting the new char from the user
            
            xorq    %r13, %r13		# %r13 = 0
            movb    -15(%rbp), %r13b		# set the new char to %r13
                       
            movq    %r14, %rdi		# set the address of the first Pstring to %rdi
            movb    %r12b, %sil		# set the old char to %rsi
            movb    %r13b, %dl		# set the new char to %rdx
            call    replaceChar		# call the function replaceChar
            
            movq    %r15, %rdi		# set the address of the second Pstring to %rdi
            movb    %r12b, %sil		# set the old char to %rsi
            movb    %r13b, %dl		# set the new char to %rdx
            call    replaceChar		# call the function replaceChar
            
            addq    $1,%r14			# adding 1 to the address of the first Pstring in order to get the first string
            addq    $1,%r15			# adding 1 to the address of the second Pstring in order to get the second string
            movq    %r14, %rcx		# set the address of the first string to %rcx
            movq    %r15, %r8			# set the address of the second string to %r8
            movq    $print_case_52, %rdi	# set the print format as the first parameter of printf
            xorq    %rax, %rax		# %rax = 0
            call    printf			# call the function printf
            jmp .end_of_run_func              # Goto the end of run_func
    .case_53:
            movq    %rsi, %r14		# set the address of the first Pstring to %r14
            movq    %rdx, %r15		# set the address of the second Pstring to %r15
            
            movq    $scan_d, %rdi		# set the first parameter of scanf to %rdi
            leaq    -16(%rbp), %rsi		# set the second parameter of scanf to %rsi
            xorq    %rax, %rax		# %rax = 0
            call    scanf			# getting i from the user
            xorq    %rax, %rax		# %rax = 0
            
            xorq    %r12, %r12		# %r12 = 0
            movb    -16(%rbp), %r12b		# set i into %r12
            
            movq    $scan_d, %rdi		# set the first parameter of scanf to %rdi
            leaq    -15(%rbp), %rsi		# set the second parameter of scanf to %rsi
            xorq    %rax, %rax		# %rax = 0
            call    scanf			# getting j from the user
            xorq    %rax, %rax		# %rax = 0
            
            xorq    %r13, %r13		# %r13 = 0
            movb    -15(%rbp), %r13b		# set j into %r13
            
            movq    %r14, %rdi		# set the address of the first Pstring to %rdi
            movq    %r15, %rsi		# set the address of the second Pstring to %rsi
            xorq    %rdx,%rdx			# %rdx = 0
            movb    %r12b, %dl		# set i into %rdx
            xorq    %rcx,%rcx			# %rcx = 0
            movb    %r13b, %cl		# set j into %rcx
            call    pstrijcpy			# call the function pstrijcpy
            
            xorq    %rsi, %rsi		# %rsi = 0
            movb    (%r14), %sil		# set the len of the first Pstring into %rsi
            addq    $1, %r14			# adding 1 to the address of the first Pstring in order to get the first string
            movq    %r14, %rdx		# set the address of the first string to %rdx
            movq    $print_case_53, %rdi	# set the print format as the first parameter of printf
            xorq    %rax, %rax		# %rax = 0
            call    printf			# call the function printf
            xorq    %rax,%rax			# %rax = 0
            
            xorq    %rsi, %rsi		# %rsi = 0
            movb    (%r15), %sil		# set the len of the second Pstring into %rsi
            addq    $1, %r15			# adding 1 to the address of the second Pstring in order to get the second string
            movq    %r15, %rdx		# set the address of the second string to %rdx
            movq    $print_case_53, %rdi	# set the print format as the first parameter of printf
            xorq    %rax, %rax		# %rax =0
            call    printf			# call the function printf
            xorq    %rax,%rax			# %rax = 0
            jmp .end_of_run_func		# Goto the end of run_func
    .case_54:
            movq    %rsi, %r14		# set the address of the first Pstring to %r14
            movq    %rdx, %r15		# set the address of the second Pstring to %r15
            
            movq    %r14, %rdi		# set the address of the first Pstring to %rdi
            call    swapCase			# call the function swapCase
            
            xorq    %rsi, %rsi		# %rsi = 0
            movb    (%r14), %sil		# set the len of the first string to %rsi
            addq    $1, %r14			# adding 1 to the address of the first Pstring in order to get the first string
            movq    %r14, %rdx		# set the address of the first string to %rdx
            movq    $print_case_54, %rdi	# set the print format as the first parameter of printf
            xorq    %rax, %rax		# %rax = 0
            call    printf			# call the function printf
            
            movq    %r15, %rdi		# set the address of the second Pstring to %rdi
            call    swapCase			# call the function swapCase
            
            xorq    %rsi, %rsi		# %rsi = 0
            movb    (%r15), %sil		# set the len of the second Pstring into %rsi
            addq    $1, %r15			# adding 1 to the address of the second Pstring in order to get the second string
            movq    %r15, %rdx		# set the address of the second string to %rdx
            movq    $print_case_54, %rdi	# set the print format as the first parameter of printf
            xorq    %rax, %rax		# %rax = 0
            call    printf			# call the function printf
            jmp .end_of_run_func		# Goto the end of run_func
    .case_55:
            movq    %rsi, %r14		# set the address of the first Pstring to %r14
            movq    %rdx, %r15		# set the address of the second Pstring to %r15
            
            movq    $scan_d, %rdi		# set the first parameter of scanf to %rdi
            leaq    -16(%rbp), %rsi		# set the second parameter of scanf to %rsi
            xorq    %rax, %rax		# %rax = 0
            call    scanf			# getting i from the user
            xorq    %rax, %rax		# %rax = 0
            
            xorq    %r12, %r12		# %r12 = 0
            movb    -16(%rbp), %r12b		# set i into %r12
            
            movq    $scan_d, %rdi		# set the first parameter of scanf to %rdi
            leaq    -15(%rbp), %rsi		# set the second parameter of scanf to %rsi
            xorq    %rax, %rax		# %rax = 0
            call    scanf			# getting j from the user
            xorq    %rax, %rax		# %rax = 0
            
            xorq    %r13, %r13		# %r13 = 0
            movb    -15(%rbp), %r13b		# set j into %r13
            
            movq    %r14, %rdi		# set the address of the first Pstring to %rdi
            movq    %r15, %rsi		# set the address of the second Pstring to %rsi
            xorq    %rdx,%rdx			# %rdx = 0
            movb    %r12b, %dl		# set i into %rdx
            xorq    %rcx,%rcx			# %rcx = 0
            movb    %r13b, %cl		# set j into %rcx
            call    pstrijcmp			# call the function pstrijcmp
            
            movq    %rax,%rsi			# set the return value to %rsi
            movq    $print_case_55, %rdi	# set the print format as the first parameter of printf
            xorq    %rax, %rax		# %rax = 0
            call    printf			# call the function printf
            jmp .end_of_run_func		# Goto the end of run_func
    .case_invalid_input:
            movq    $invalid_option, %rdi	# set the print format as the first parameter of printf
            xorq    %rax, %rax		# %rax = 0
            call    printf			# call the function printf
    .end_of_run_func:
    	    add     $16, %rsp			# releasing the allocated memory from the stack
            movq    %rbp, %rsp		# restoring the old stack pointer.
            pop     %rbp			# restoring the old frame pointer.
            xorq    %rax,%rax			# %rax = 0
            ret				# finish
