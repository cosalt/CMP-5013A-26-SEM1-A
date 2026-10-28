.data


.text
main:
partC:
	li $t0, 0 
	li $t1, 1 
	li $t2, 0 
	li $t3, 10 
loopC:
	beq $t2, $t3, doneC
	move $a0, $t0 
	li $v0, 1 
	syscall 
	li $a0, 32 
	li $v0, 11 
	syscall
	add $t0, $t0, $t1 
	sub $t1, $t0, $t1
	addi $t2, $t2, 1 
	j loopC 
doneC:
	li $v0, 10
	syscall 
