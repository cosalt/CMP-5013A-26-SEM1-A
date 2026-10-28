.data

	array: .word 1, 2, 2, 3, 6 
	length: .word 5 
	
	
.text 

	main:
		la $t0, array 
		li $t1, 0     
		lw $t2, length
		li $t3, 0 
 		
############### COMPLETE YOUR CODE BELOW THIS LINE #######	

		SUM:	
	 	lw $t4, 0($t0) 
	 	add $t3, $t4, $t3 
	 	addi $t0, $t0, 4 
	 	addi $t1, $t1, 1 
	 	blt $t1, $t2, SUM 
	 	la $s0, ($t3) 
	 	
	 	la $t0, array 
	 	la $t1, 0 

	 	
	 	AVG:	
	 	div $s0, $t2 
	 	mflo $s1 
	 
	 	
	 	li $t5, 0 
	 	MAX:	
	 	lw $t4, 0($t0)
	 	bgt $t4, $t5, NEWMAX 
	 	addi $t0, $t0, 4 
	 	addi $t1, $t1, 1 
	 	blt $t1, $t2, MAX 
	 	j EOMAX 
	 	NEWMAX:
	 	la $t5, ($t4) 
	 	addi $t0, $t0, 4 
	 	addi $t1, $t1, 1 
	 	blt $t1, $t2, MAX 
	 	EOMAX: 
	 	la $s2, ($t5) 
	 	
	 	la $t0, array 
	 	la $t1, 0 
	 	
	 	
	 	la $t6, ($s2) 
	 	MIN:	
	 	lw $t4, 0($t0) 
	 	blt $t4, $t6, NEWMIN
	 	addi $t0, $t0, 4 
	 	addi $t1, $t1, 1 
	 	blt $t1, $t2, MIN
	 	j EOMIN 
	 	NEWMIN:	
	 	la $t6, ($t4) 
	 	addi $t0, $t0, 4 
	 	addi $t1, $t1, 1 
	 	blt $t1, $t2, MIN 
	 	EOMIN: 
	 	la $s3, ($t6) 
	
	 	
################COMPLETE YOUR CODE ABOVE THIS LINE #######
		
		li $v0 10    
		syscall
