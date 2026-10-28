.data


.text
main:
partC:
	li $t0, 0 # a = 0 (first fibonacci number)
	li $t1, 1 # b = 1 (second fibonacci number)
	li $t2, 0 # count = 0 (numbers printed so far)
	li $t3, 10 # limit = 10 numbers to print
loopC:
	beq $t2, $t3, doneC # if count == limit, ten numbers are printed, so leave the loop
	move $a0, $t0 # a0 = a, the value to print
	li $v0, 1 # service 1 = print integer
	syscall # print a
	li $a0, 32 # a0 = 32, the ascii code for a space
	li $v0, 11 # service 11 = print character
	syscall # print a space
	add $t0, $t0, $t1 # a = a + b (a now holds the NEXT number)
	sub $t1, $t0, $t1 # b = new a - b, which gets the old a back
	addi $t2, $t2, 1 # count = count + 1
	j loopC # go back to the top of the loop
doneC:
	li $v0, 10 # service 10 = exit
	syscall # stop
