# Change the ONE line after "main:" to pick which part runs
# (j partA / j partB / j partC).


.data # this .data section is where you can simulate stored data in random access memory

	array: .word 5, 2, 6, 7, 1 # you can write any label which ends in a colon such as 'array:' <- PUT YOUR STUDENT NUMBERS HERE
	length: .word 5 # <--- THIS IS THE NUMBER OF ELEMENTS IN THE ARRAY

	# text for the optional printing in part b (syscall 4 prints these)
	msgSum: .asciiz "Sum: "
	msgMin: .asciiz "Min: "
	msgMax: .asciiz "Max: "
	msgAvg: .asciiz "Avg: "
	newline: .asciiz "\n"


.text # this section is where you write your main script

main:
	j partA # note: change this to partB / partC to run a different part


# part A
# c code:  int t0 = 3;
#          if (t0 < 7)
#              t1 = 7 + t0;
#          else
#              t1 = t0 + t0;
# Test with t0 = 3 (expect t1 = 10), then t0 = 9 (expect t1 = 18)

partA:
	li $t0, 3 # t0 = 3 (change this to 9 to test the else path)
	slti $t2, $t0, 7 # flag t2 = 1 if t0 < 7, otherwise 0
	beq $t2, $zero, elseA # flag is 0 (condition false), so jump to the else part
	addi $t1, $t0, 7 # then part: t1 = t0 + 7
	j doneA # jump over the else part so it does not also run
elseA:
	add $t1, $t0, $t0 # else part: t1 = t0 + t0
doneA:
	j finish # leave Part A (result is in $t1)


# part B
# sum, average, min and max of the digits in 'array'
#
# Register plan (the first four are loaded by the starter code):
#   $t0 = base address of array      $t1 = i (index)
#   $t2 = length                     $t3 = sum
#   $t4 = address of A[i]            $t5 = A[i] (current element)
#   $t6 = comparison flag
#   $s0 = min    $s1 = max    $s2 = average

partB:
	la $t0, array # t0 = base address of the array (given)
	li $t1, 0 # i = 0 (given)
	lw $t2, length # t2 = number of elements, 5 (given)
	li $t3, 0 # sum = 0 (given)

	lw $s0, 0($t0) # min = A[0], assume the first element is the smallest so far
	lw $s1, 0($t0) # max = A[0], assume the first element is the largest so far

loopB:
	beq $t1, $t2, doneB # if i == length, every element is done, so leave the loop
	sll $t4, $t1, 2 # t4 = i * 4 (each word is 4 bytes)
	add $t4, $t4, $t0 # t4 = base address + i*4 = address of A[i]
	lw $t5, 0($t4) # t5 = A[i]
	add $t3, $t3, $t5 # sum = sum + A[i]
	slt $t6, $t5, $s0 # flag = 1 if A[i] < min
	beq $t6, $zero, skipMin # flag is 0 (not smaller), so leave min alone
	move $s0, $t5 # A[i] is the new min
skipMin:
	slt $t6, $s1, $t5 # flag = 1 if max < A[i] (operands swapped compared with min)
	beq $t6, $zero, skipMax # flag is 0 (not bigger), so leave max alone
	move $s1, $t5 # A[i] is the new max
skipMax:
	addi $t1, $t1, 1 # i = i + 1
	j loopB # go back to the top of the loop
doneB:
	div $t3, $t2 # divide sum by length: lo = quotient, hi = remainder
	mflo $s2 # average = quotient (whole number, remainder is dropped)












	# print the results
	la $a0, msgSum # a0 = address of the text "Sum: "
	li $v0, 4 # service 4 = print string
	syscall # print "Sum: "
	move $a0, $t3 # a0 = the sum
	li $v0, 1 # service 1 = print integer
	syscall # print the sum
	la $a0, newline # a0 = address of the newline text
	li $v0, 4 # service 4 = print string
	syscall # print a newline

	la $a0, msgMin # a0 = address of the text "Min: "
	li $v0, 4 # service 4 = print string
	syscall # print "Min: "
	move $a0, $s0 # a0 = the min
	li $v0, 1 # service 1 = print integer
	syscall # print the min
	la $a0, newline # a0 = address of the newline text
	li $v0, 4 # service 4 = print string
	syscall # print a newline

	la $a0, msgMax # a0 = address of the text "Max: "
	li $v0, 4 # service 4 = print string
	syscall # print "Max: "
	move $a0, $s1 # a0 = the max
	li $v0, 1 # service 1 = print integer
	syscall # print the max
	la $a0, newline # a0 = address of the newline text
	li $v0, 4 # service 4 = print string
	syscall # print a newline

	la $a0, msgAvg # a0 = address of the text "Avg: "
	li $v0, 4 # service 4 = print string
	syscall # print "Avg: "
	move $a0, $s2 # a0 = the average
	li $v0, 1 # service 1 = print integer
	syscall # print the average
	la $a0, newline # a0 = address of the newline text
	li $v0, 4 # service 4 = print string
	syscall # print a newline

	j finish # leave Part B


# part c
# print the first ten Fibonacci numbers, each followed by a space:
#   0 1 1 2 3 5 8 13 21 34
#
# Register plan:
#   $t0 = a (current number)    $t1 = b (the next number)
#   $t2 = next_val (temporary)  $t3 = count    $t4 = limit
#
# lab note: part C must also be saved as its own file, A_partC.asm.

partC:
	li $t0, 0 # a = 0 (first Fibonacci number)
	li $t1, 1 # b = 1 (second Fibonacci number)
	li $t3, 0 # count = 0 (how many numbers printed so far)
	li $t4, 10 # limit = 10 numbers to print
loopC:
	beq $t3, $t4, doneC # if count == limit, ten numbers are printed, so leave the loop
	move $a0, $t0 # a0 = a, the value to print
	li $v0, 1 # service 1 = print integer
	syscall # print a
	li $a0, 32 # a0 = 32, the ASCII code for a space
	li $v0, 11 # service 11 = print character
	syscall # print a space
	add $t2, $t0, $t1 # next_val = a + b (must happen before a is overwritten)
	move $t0, $t1 # a = b
	move $t1, $t2 # b = next_val
	addi $t3, $t3, 1 # count = count + 1
	j loopC # go back to the top of the loop
doneC:
	j finish # leave Part C

# done

finish:
	li $v0, 10 # service 10 = exit the program
	syscall # end the program
