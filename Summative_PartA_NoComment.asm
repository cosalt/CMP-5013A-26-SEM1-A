.data

.text
main:
	li $t0, 3
	slti $t2, $t0, 7
	beq $t2, $zero, else
	addi $t1, $t0, 7
	j end
	else:
	add $t1, $t0, $t0
	end:
	

	li $v0, 10
	syscall
