.data # data section, things stored in memory

.text # code section
main: # label where the program starts
	li $t0, 9 # load immediate, the constant into t0
	slti $t2, $t0, 7 #set if less than immediate, if t0 less than 7, then set t1 to 1, else set to 0
	beq $t2, $zero, else # if $t2 == $zero, then jump to else, otherwise, carry on
	addi $t1, $t0, 7 #add t0 + const(7) into t1
	j end # jump to end
	else: # if t0<7 was false, it would've jumped to here. 
	add $t1, $t0, $t0 # add $t0 + $t0 into $t1
	end: # end
	
	move $a0, $t1       # copy value to show into $a0
	li   $v0, 1         # service 1 = print integer
	syscall             # print it

	
	li $v0, 10 #service 10 exits the program
	syscall # calls the system service



# comment-less version on the bottom here

.data

.text
main:
	li $t0, 9
	slti $t2, $t0, 7
	beq $t2, $zero, else
	addi $t1, $t0, 7
	j end
	else:
	add $t1, $t0, $t0
	end:
	

	li $v0, 10
	syscall
	
