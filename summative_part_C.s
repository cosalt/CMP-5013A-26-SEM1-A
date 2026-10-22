partC:
	li $t0, 0 # a = 0 (first fibonacci number)
	li $t1, 1 # b = 1 (second fibonacci number)
	li $t3, 0 # count = 0 (numbers printed so far)
	li $t4, 10 # limit = 10 numbers to print
loopC:
	beq $t3, $t4, doneC # if count == limit, ten numbers are printed, so leave the loop
	move $a0, $t0 # a0 = a, the value to print
	li $v0, 1 # service 1 = print integer
	syscall # print a
	li $a0, 32 # a0 = 32, the ascii code for a space
	li $v0, 11 # service 11 = print character
	syscall # print a space
	add $t2, $t0, $t1 # next_val = a + b (do before bec a is overwritten)
	move $t0, $t1 # a = b
	move $t1, $t2 # b = next_val
	addi $t3, $t3, 1 # count = count + 1
	j loopC # go back to the top of the loop
doneC:
	j finish # leave part c
